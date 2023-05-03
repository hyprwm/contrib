DESTDIR ?= /
PREFIX ?= $(DESTDIR)usr/local
EXEC_PREFIX ?= $(PREFIX)
BINDIR ?= $(EXEC_PREFIX)/bin

install: scratchpad
	@install -v -D -m 0755 scratchpad --target-directory "$(BINDIR)"

uninstall: scratchpad
	rm "$(BINDIR)/scratchpad"
