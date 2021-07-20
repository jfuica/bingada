DESTDIR = /opt/BingAda

all:
	gprbuild -p bingada

install:
	mkdir -p $(DESTDIR)
	cp -rp bingada.desktop bingada.png bin/bingada bombo.png \
		drum_spin.png bingo_cards.csv media messages \
		README.md bingada.css bingada-dark.css $(DESTDIR)

AppImage:
	make install DESTDIR=AppDir
	wget -nv -c https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage
	chmod +x linuxdeploy-x86_64.AppImage
	./linuxdeploy-x86_64.AppImage \
	--executable bin/bingada \
	--desktop-file bingada.desktop --icon-file=bingada.png \
	--appdir AppDir --output appimage
