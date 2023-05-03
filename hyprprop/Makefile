DESTDIR ?= /
PREFIX ?= $(DESTDIR)usr/local
EXEC_PREFIX ?= $(PREFIX)
DATAROOTDIR ?= $(PREFIX)/share
BINDIR ?= $(EXEC_PREFIX)/bin
MANDIR ?= $(DATAROOTDIR)/man
MAN1DIR ?= $(MANDIR)/man1

all: hyprprop.1

hyprprop.1: hyprprop.1.scd
	scdoc < $< > $@

install: hyprprop.1 hyprprop
	@install -v -D -m 0644 hyprprop.1 --target-directory "$(MAN1DIR)"
	@install -v -D -m 0755 hyprprop --target-directory "$(BINDIR)"

uninstall: hyprprop.1 hyprprop
	rm "$(MAN1DIR)/hyprprop.1"
	rm "$(BINDIR)/hyprprop"
