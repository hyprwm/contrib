"""pyrprconf configuration module"""

from collections import defaultdict
from dataclasses import dataclass
import os
import re
import sys
from typing import Any, Callable, Dict, List, Tuple, Union

COMMAND_TYPES = ["keyword", "dispatch"]


@dataclass
class EventHandler:
    send: Union[bytes, None] = None
    set: Union[str, None] = None
    reset: Union[str, None] = None
    check: Union[str, None] = None


HandlerDict = Dict[str, Dict[re.Pattern, List[EventHandler]]]
Loaders = List[bytes]
Unloaders = Loaders
Logger = Callable[[object], None]


@dataclass
class Configuration:
    unloaders: Union[Loaders, None]
    handlers: Union[HandlerDict, None]


def batch(batch: List[str]):
    if batch:
        return f"[[BATCH]] {str.join(';', batch)}".encode()
    return None


def _register_tokens(tokens: Dict[str, str], section: Dict[str, Any]) -> Dict[str, str]:
    if "tokens" in section:
        tokens.update(section["tokens"])


def _resolve_commands(
    command: str, commands: Dict[str, Any], tokens: Dict[str, str]
) -> List[str]:
    return list(f"/{command} {keyword}".format_map(tokens) for keyword in commands)


def _resolve_binds(
    binds: Dict[str, str], tokens: Dict[str, str]
) -> Tuple[List[str], List[str]]:
    resolved = {
        key.format_map(tokens): cmd.format_map(tokens) for (key, cmd) in binds.items()
    }
    return list(f"/keyword bind {key},{cmd}" for key, cmd in resolved.items()), list(
        f"/keyword unbind {key}" for key in resolved
    )


def _register_handlers(
    handlers: HandlerDict, events: List[Dict[str, Any]], tokens: Dict[str, str]
):
    for event in events:
        try:
            commands = batch(
                [
                    resolved
                    for command_type in COMMAND_TYPES
                    if command_type in event
                    for resolved in _resolve_commands(
                        command_type, event[command_type], tokens
                    )
                ]
            )

            set = None
            reset = None
            check = None

            gate = event.get("gate", None)
            if gate:
                set = gate.get("set", None)
                reset = gate.get("reset", None)
                check = gate.get("check", None)

            pattern = re.compile(event["match"].format_map(tokens))

            handlers[event["event"]][pattern].append(
                EventHandler(send=commands, set=set, reset=reset, check=check)
            )

        except KeyError as err:
            print(
                f"Event in section '{tokens['@']}' missing required key: {err.args[0]}",
                file=sys.stderr,
            )
            continue


def _parse_pyprconf(config: Dict[str, Any], pyrpconf: Dict) -> Tuple[Dict, List[str]]:
    extensions = [name for name in config if name.startswith("x-")]
    for name in extensions:
        if name.startswith("x-"):
            config.pop(name)

    specialbinds = []

    bindreload = pyrpconf.get("bindreload", None)
    if bindreload:
        cmd = f"/keyword bind {bindreload},exec,kill -USR1 {os.getpid()}"
        specialbinds.append(cmd)

    bindunload = pyrpconf.get("bindunload", None)
    if bindunload:
        cmd = f"/keyword bind {bindunload},exec,kill -USR2 {os.getpid()}"
        specialbinds.append(cmd)

    return config, specialbinds


def _parse_range(log: Logger, rangedef: Union[Dict[str, Any], None]) -> List[int]:
    if rangedef:
        if len(rangedef) < 3:
            log(f"range must be defined as: [start, stop, step]")
            return [0]

        return range(rangedef[0], rangedef[1], rangedef[2])

    return [0]


def parse(configdict: Dict[str, Any], log: Logger) -> Tuple[Loaders, Configuration]:
    loaders = list()
    unloaders = list()
    handlers = defaultdict(lambda: defaultdict(list))

    pyrpconf: Union[Dict, None] = configdict.pop("pyprconf", None)
    if pyrpconf:
        configdict, specialbinds = _parse_pyprconf(configdict, pyrpconf)
        if specialbinds:
            loaders.append(specialbinds)

    for name, section in configdict.items():
        log(f"processing section: {name}")

        rangedef = section.get("range", None)
        range_tokens = _parse_range(log, rangedef)

        for range_token in range_tokens:
            tokens = {"@": name, "#": range_token}
            _register_tokens(tokens, section)

            for command_type in COMMAND_TYPES:
                if command_type in section:
                    loaders.append(
                        _resolve_commands(command_type, section[command_type], tokens)
                    )

            if "bind" in section:
                binds, unbinds = _resolve_binds(section["bind"], tokens)
                loaders.append(binds)
                unloaders.append(unbinds)
            if "events" in section:
                _register_handlers(handlers, section["events"], tokens)

    handlers.default_factory = None
    return [batch(loader) for loader in loaders], Configuration(
        [batch(unloader) for unloader in unloaders], handlers
    )
