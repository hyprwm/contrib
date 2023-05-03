DESTDIR ?= /
PREFIX ?= $(DESTDIR)usr/local
EXEC_PREFIX ?= $(PREFIX)
BINDIR ?= $(EXEC_PREFIX)/bin

install: shellevents shellevents_default.sh
	@install -v -D -m 0755 shellevents shellevents_default.sh --target-directory "$(BINDIR)"

uninstall: shellevents shellevents_default.sh
	rm "$(BINDIR)/shellevents"
	rm "$(BINDIR)/shellevents_default.sh"
