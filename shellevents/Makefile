PREFIX ?= /usr
BINDIR ?= $(PREFIX)/bin

install: shellevents shellevents_default.sh
	@install -v -D -m 0755 shellevents shellevents_default.sh --target-directory "$(BINDIR)"
