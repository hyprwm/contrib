DESTDIR ?= /
PREFIX ?= $(DESTDIR)usr/local
EXEC_PREFIX ?= $(PREFIX)
BINDIR ?= $(EXEC_PREFIX)/bin

install: try_swap_workspace
	@install -v -D -m 0755 try_swap_workspace --target-directory "$(BINDIR)"

uninstall: try_swap_workspace
	rm "$(BINDIR)/try_swap_workspace"
