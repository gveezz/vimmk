VIM_DIR = ./vim/
GUIV = 3
GUI = gtk-$(GUIV)

NCPUS = $(shell cat /proc/cpuinfo  | grep processor | wc -l)

.PHONY: all update clean uninstall config compile install

all: update clean uninstall config compile install

clean:
	sudo $(MAKE) -C $(VIM_DIR) clean distclean

uninstall: 
	sudo $(MAKE) -C $(VIM_DIR) uninstall

update:
	git fetch --all --tags; \
	git submodule update; \
  	git pull

config:
	cd $(VIM_DIR); \
	export CFLAGS="-Ofast"; \
    ./configure \
      --prefix=/usr/local/ \
      --with-features=huge \
      --enable-gui=$(GUI) \
      --enable-multibyte \
      --enable-wayland \
      --enable-fork \
      --enable-terminal=no \
      --enable-xim \
      --with-tlib=ncurses \
      --with-x \
      --enable-fontset \
      --enable-autoservername \
      --disable-rightleft \
      --disable-arabic \
      --disable-farsi \
      --enable-gpm=yes \
      --enable-cscope \
      --with-gnome-includes=/usr/include/gtk-${gtkv}.0 \
      --with-compiledby=simo.zz.dev@gmail.com

compile:
	$(MAKE) -C $(VIM_DIR) -j $(NCPUS)

install:
	sudo $(MAKE) -C $(VIM_DIR) install
