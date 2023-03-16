PREFIX ?= /usr
BINDIR ?= $(PREFIX)/bin
MANDIR ?= $(PREFIX)/share/man

all: hyprprop.1

hyprprop.1: hyprprop.1.scd
	scdoc < $< > $@

install: hyprprop.1 hyprprop
	@install -v -D -m 0644 hyprprop.1 --target-directory "$(MANDIR)/man1"
	@install -v -D -m 0755 hyprprop --target-directory "$(BINDIR)"
