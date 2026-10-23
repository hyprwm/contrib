#!/usr/bin/env python3

# pyprconf - dynamic, templated configuration
#   and event handling for Hyprland
#
# Usage:
#   pyrpconf /path/to/conf1.yaml /path/to/conf2.yaml
#
# Add the command to hyprland.conf using exec-once (probably toward the bottom).
#
# The configuration file must be in yaml, but support for other formats would
# be pretty easy to add, as long as they parse to a dict of the same shape.

import os
import signal
import socket
import sys
from typing import Callable, Dict, List, Union

import yaml

import pyprconf.configuration as configuration
from pyprconf.configuration import Configuration, EventHandler

SOCK1_ADDR = "/tmp/hypr/" + os.environ["HYPRLAND_INSTANCE_SIGNATURE"] + "/.socket.sock"

SOCK2_ADDR = "/tmp/hypr/" + os.environ["HYPRLAND_INSTANCE_SIGNATURE"] + "/.socket2.sock"


files: Union[List[str], None] = None
config: Configuration = None
gates: Dict[str, bool] = dict()
enabled = False


def log(object: object):
    print(object, file=sys.stderr)


def update_gate(name: str, value: bool):
    gates[name] = value


def check_gate(name: str):
    if name in gates:
        return gates[name]

    return False


def send(msg: bytes):
    log(f"=> {msg}")
    if not msg:
        return
    try:
        sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        sock.connect(SOCK1_ADDR)
    except socket.error as err:
        log(f"connect error: {err} ")
        return

    try:
        sock.sendall(msg)
        data = sock.recv(2048).decode()
        log(f"<= {data}")
        return data
    except socket.error as err:
        log(f"send error: {err}")
    finally:
        sock.close()


def configure():
    global config, enabled
    log(f"loading configuration: {files}")

    yamldoc = dict()
    for file in files:
        with open(file, mode="rb") as f:
            yamldoc.update(yaml.load(f, Loader=yaml.CSafeLoader))

    loaders, config = configuration.parse(yamldoc, log=log)
    for loader in loaders:
        send(str(loader).encode())
    enabled = True


def reload(*_):
    unload()
    configure()


def unload(*_):
    global enabled
    log(f"unloading configuration")
    enabled = False
    if config:
        for unloader in config.unloaders:
            send(str(unloader).encode())


def process_handler(send: Callable[[bytes], str], handler: EventHandler, data: str):
    if handler.check:
        if not check_gate(handler.check):
            log(f"gate check failed: {handler.check}")
            return
        else:
            log(f"gate check passed: {handler.check}")
    if handler.set:
        update_gate(handler.set, True)
        log(f"set gate: {handler.set}")
    if handler.reset:
        update_gate(handler.reset, False)
        log(f"reset gate: {handler.reset}")
    if handler.send:
        datalist = data.split(",")
        send(str(handler.send).format(*datalist).encode())


def main():
    global files
    files = sys.argv[1:]
    configure()
    signal.signal(signal.SIGUSR1, reload)
    signal.signal(signal.SIGUSR2, unload)
    signal.signal(signal.SIGTERM, unload)

    try:
        sock2 = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        sock2.connect(SOCK2_ADDR)
        sock2file = sock2.makefile()

        while enabled:
            if not config.handlers:
                log("no handlers registered, waiting for config reload...")
                signal.pause()
                continue

            line = sock2file.readline()
            if not enabled:
                continue
            name, data = line.rstrip().rsplit(">>")
            if name in config.handlers:
                for pattern, eventhandlers in config.handlers[name].items():
                    if pattern.fullmatch(data):
                        log(f"matched event <{name}> {pattern.pattern}: {data}")
                        for eventhandler in eventhandlers:
                            try:
                                process_handler(send, eventhandler, data)
                            except Exception as err:
                                log(f"error in event handler: {err}")

    except KeyboardInterrupt:
        log("stopped with keyboard interrupt")
        unload()
    finally:
        sock2.close()


if __name__ == "__main__":
    main()
