PREFIX = /usr/local
ETC = /etc

BINPROGS = \
					 gen_snap_entries

FILES = \
				snap.preset

HOOKS = \
				pacman/96-snap_entry_post.hook \
				pacman/96-img_copy_pre.hook

all: $(BINPROGS) files hooks
files: $(FILES)
hooks: $(HOOKS)

shellcheck: $(BINPROGS)
	shellcheck -W 99 --color $(BINPROGS)

install: all
	install -d $(DESTDIR)$(PREFIX)/bin
	install -m 0755 $(BINPROGS) $(DESTDIR)$(PREFIX)/bin
	install -d $(DESTDIR)$(PREFIX)/share/helpers
	install -m 0644 $(FILES) $(DESTDIR)$(PREFIX)/share/helpers
	install -d $(DESTDIR)$(ETC)/pacman.d/hooks
	install -m 0644 $(HOOKS) $(DESTDIR)$(ETC)/pacman.d/hooks

.PHONY: install all shellcheck
