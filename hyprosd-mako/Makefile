DESTDIR ?= /
PREFIX ?= $(DESTDIR)usr/local
EXEC_PREFIX ?= $(PREFIX)
DATAROOTDIR ?= $(PREFIX)/share
BINDIR ?= $(EXEC_PREFIX)/bin

SCRIPTS = brightness-notify mic-notify volume-notify

all:
	@echo "Nothing to build."

install:
	@for s in $(SCRIPTS); do \
		install -v -D -m 0755 $$s "$(BINDIR)/$$s"; \
	done

uninstall:
	@for s in $(SCRIPTS); do \
		rm -v "$(BINDIR)/$$s"; \
	done

