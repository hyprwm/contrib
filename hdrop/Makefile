DESTDIR ?= /
PREFIX ?= $(DESTDIR)usr/local
EXEC_PREFIX ?= $(PREFIX)
DATAROOTDIR ?= $(PREFIX)/share
BINDIR ?= $(EXEC_PREFIX)/bin


all: hdrop.1

hdrop.1: hdrop.1.scd

install: hdrop.1 hdrop
	@install -v -D -m 0755 hdrop --target-directory "$(BINDIR)"

uninstall: hdrop.1 hdrop
	rm "$(BINDIR)/hdrop"
