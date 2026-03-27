DESTDIR ?= /
PREFIX ?= $(DESTDIR)usr/local
EXEC_PREFIX ?= $(PREFIX)
BINDIR ?= $(EXEC_PREFIX)/bin

install: cycle-layout
	@install -v -D -m 0755 cycle-layout --target-directory "$(BINDIR)"

uninstall: cycle-layout
	rm "$(BINDIR)/cycle-layout"
