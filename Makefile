all: install

install:
	cp -v ./etc/systemd/system/iprestore.service /etc/systemd/system/.
	cp -v ./etc/iprestore.cfg /etc/.
	cp -v ./usr/local/bin/iprestore.sh /usr/local/bin/.
	cp -v ./usr/local/bin/cfg_parser.py /usr/local/bin/.
	chmod 0755 /usr/local/bin/iprestore.sh
	chmod 0755 /usr/local/bin/cfg_parser.py
	systemctl daemon-reload
