function install_init {
	if [ ! -d /etc/systemd/system ]; then
		_error "/etc/systemd/system does not exist. Is systemd installed?" 8
	fi
	civx_service
	civx_conf
	if [ $USE_ROCKSDB == 1 ]; then
		echo -e "\nDB_ENGINE=rocksdb" >> /etc/electrumx-civx.conf
	fi
	systemctl daemon-reload
	systemctl enable electrumx-civx
	systemctl status electrumx-civx
	_info "Use service electrumx-civx start to start electrumx-civx once it's configured"
}

function civx_service {
	rm /etc/systemd/system/electrumx-civx.service
	echo "[Unit]" >> /etc/systemd/system/electrumx-civx.service
	echo "Description=Electrumx-CIVX" >> /etc/systemd/system/electrumx-civx.service
	echo "After=network.target" >> /etc/systemd/system/electrumx-civx.service
	echo -e "\n[Service]" >> /etc/systemd/system/electrumx-civx.service
	echo "EnvironmentFile=/etc/electrumx-civx.conf" >> /etc/systemd/system/electrumx-civx.service
	echo "ExecStart=/usr/local/bin/electrumx_server" >> /etc/systemd/system/electrumx-civx.service
	echo "User=electrumx-civx" >> /etc/systemd/system/electrumx-civx.service
	echo "LimitNOFILE=8192" >> /etc/systemd/system/electrumx-civx.service
	echo "TimeoutStopSec=30min" >> /etc/systemd/system/electrumx-civx.service
	echo -e "\n[Install]" >> /etc/systemd/system/electrumx-civx.service
	echo "WantedBy=multi-user.target" >> /etc/systemd/system/electrumx-civx.service
}

function civx_conf {
	rm /etc/electrumx-civx.conf
	echo "# default /etc/electrumx-civx.conf for systemd" >> /etc/electrumx-civx.conf
	echo "COIN=CivX" >> /etc/electrumx-civx.conf
	echo -e "\n# REQUIRED" >> /etc/electrumx-civx.conf
	echo "DB_DIRECTORY = /db-civx" >> /etc/electrumx-civx.conf
	echo "# CivX Node RPC Credentials" >> /etc/electrumx-civx.conf
	echo "DAEMON_URL = http://yourusernamehere:yourpasswordhere@localhost:4561/" >> /etc/electrumx-civx.conf
	echo -e "\n# See http://electrumx.readthedocs.io/en/latest/environment.html for" >> /etc/electrumx-civx.conf
	echo "# information about other configuration settings you probably want to consider." >> /etc/electrumx-civx.conf
}
