PREFIX ?= /usr
BINDIR ?= $(PREFIX)/bin
MANDIR ?= $(PREFIX)/share/man

all: grimblast.1

grimblast.1: grimblast.1.scd
	scdoc < $< > $@

install: grimblast.1 grimblast
	@install -v -D -m 0644 grimblast.1 --target-directory "$(MANDIR)/man1"
	@install -v -D -m 0755 grimblast --target-directory "$(BINDIR)"
