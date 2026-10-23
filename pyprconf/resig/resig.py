import getopt
import hashlib
import os
import shutil
import signal
import sys


def usage():
    print(
        """
resig - start a program once, then signal if called again
Usage:
  resig -h|--help
  resig -r|--reset
    resets the program database
  resig -s signal|--signal=signal program args...
    starts program with args, and adds it to the
    program database. when called again with the same
    program and args, program will be signaled with
    signal instead of being started again.
"""
    )


def get_data_dir() -> str:
    runtime_dir = os.environ.get("XDG_RUNTIME_DIR") or "/tmp"
    data_dir = os.path.join(runtime_dir, "resig")
    os.makedirs(data_dir, exist_ok=True)
    return data_dir


def reset():
    try:
        shutil.rmtree(get_data_dir())
        return 0
    except shutil.Error as err:
        print(f"error resetting program database: {err}")
        return 3


def main():
    try:
        opts, args = getopt.getopt(sys.argv[1:], "hrs:", ["help", "reset", "signal="])
    except getopt.GetoptError as err:
        print(err, file=sys.stderr)
        sys.exit(2)

    sig = signal.Signals["SIGUSR1"]

    for opt, arg in opts:
        if opt in ("-h", "--help"):
            usage()
            sys.exit()
        elif opt in ("-r", "--reset"):
            sys.exit(reset())
        elif opt in ("-s", "--signal"):
            sig = signal.Signals[arg]
        else:
            assert False, "unknown option"

    data_dir = get_data_dir()
    key = hashlib.md5(str(args).encode()).hexdigest()
    key_path = os.path.join(data_dir, key)

    print(f"program: {args}", file=sys.stderr)
    print(f"keypath: {key_path}", file=sys.stderr)

    pid = None
    if os.path.isfile(key_path):
        with open(key_path, "r") as f:
            pid = int(f.readline())

        print(f"signaling {sig.name}: {pid}", file=sys.stderr)
        try:
            os.kill(pid, sig.value)
            print(pid)
        except ProcessLookupError as err:
            print(f"failed sending signal: {err}", file=sys.stderr)
            os.remove(key_path)
    else:
        pid = os.spawnvp(os.P_NOWAIT, args[0], args)
        print(f"added: {pid}", file=sys.stderr)
        with open(key_path, mode="x") as f:
            f.write(str(pid))
        print(pid)


if __name__ == "__main__":
    main()
