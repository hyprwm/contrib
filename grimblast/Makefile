DESTDIR ?= /
PREFIX ?= $(DESTDIR)usr/local
EXEC_PREFIX ?= $(PREFIX)
DATAROOTDIR ?= $(PREFIX)/share
BINDIR ?= $(EXEC_PREFIX)/bin
MANDIR ?= $(DATAROOTDIR)/man
MAN1DIR ?= $(MANDIR)/man1

all: grimblast.1

grimblast.1: grimblast.1.scd
	scdoc < $< > $@

install: grimblast.1 grimblast
	@install -v -D -m 0644 grimblast.1 --target-directory "$(MAN1DIR)"
	@install -v -D -m 0755 grimblast --target-directory "$(BINDIR)"

uninstall: grimblast.1 grimblast
	rm "$(MAN1DIR)/grimblast.1"
	rm "$(BINDIR)/grimblast"
