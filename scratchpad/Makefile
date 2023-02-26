PREFIX ?= /usr
BINDIR ?= $(PREFIX)/bin

install: scratchpad
	@install -v -D -m 0755 scratchpad --target-directory "$(BINDIR)"

uninstall: scratchpad
	rm "$(BINDIR)/scratchpad"
