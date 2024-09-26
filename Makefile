Vers = 1.0
Arch = all
Pkg  = iprestore
dir  = $(Pkg)_$(Vers)_$(Arch)

all: install

install:
	cp -v ./etc/systemd/system/iprestore.service /etc/systemd/system/.
	cp -v ./etc/iprestore.cfg /etc/.
	cp -v ./usr/local/bin/iprestore.sh /usr/local/bin/.
	cp -v ./usr/local/bin/cfg_parser.py /usr/local/bin/.
	chmod 0755 /usr/local/bin/iprestore.sh
	chmod 0755 /usr/local/bin/cfg_parser.py
	systemctl daemon-reload

package: 
	mkdir -p deb/$(dir)/DEBIAN
	cp -v -r ./etc deb/$(dir)/
	cp -v -r ./usr deb/$(dir)/
	cp -v -r ./DEBIAN/ deb/$(dir)/
	chmod 0755 ./deb/$(dir)/DEBIAN/preinst
	chmod 0755 ./deb/$(dir)/DEBIAN/postinst
	sed -i -E "s/^Version: [0-9]+\.[0-9]/Version: ${Vers}/g" deb/$(dir)/DEBIAN/control
	sed -i -E "s/^Architecture: .+/Architecture: ${Arch}/g" deb/$(dir)/DEBIAN/control
	dpkg-deb --build ./deb/$(dir)/
