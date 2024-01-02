DESTDIR ?= /
PREFIX ?= $(DESTDIR)usr/local
EXEC_PREFIX ?= $(PREFIX)
DATAROOTDIR ?= $(PREFIX)/share
BINDIR ?= $(EXEC_PREFIX)/bin
MANDIR ?= $(DATAROOTDIR)/man
MAN1DIR ?= $(MANDIR)/man1

all: hdrop.1

hdrop.1: hdrop.1.scd
	scdoc < $< > $@

install: hdrop.1 hdrop
	@install -v -D -m 0644 hdrop.1 --target-directory "$(MAN1DIR)"
	@install -v -D -m 0755 hdrop --target-directory "$(BINDIR)"

uninstall: 
	rm "$(MAN1DIR)/hdrop.1"
	rm "$(BINDIR)/hdrop"
