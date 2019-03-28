function install_init {
	if [ ! -d /etc/systemd/system ]; then
		_error "/etc/systemd/system does not exist. Is systemd installed?" 8
	fi
	exos_service
	exos_conf
	if [ $USE_ROCKSDB == 1 ]; then
		echo -e "\nDB_ENGINE=rocksdb" >> /etc/exos-electrumx.conf
	fi
	systemctl daemon-reload
	systemctl enable exos-electrumx
	systemctl status exos-electrumx
	_info "Use service exos-electrumx start to start exos-electrumx once it's configured"
}

function exos_service {
	rm /etc/systemd/system/exos-electrumx.service
	echo "[Unit]" >> /etc/systemd/system/exos-electrumx.service
	echo "Description=EXOS-Electrumx" >> /etc/systemd/system/exos-electrumx.service
	echo "After=network.target" >> /etc/systemd/system/exos-electrumx.service
	echo -e "\n[Service]" >> /etc/systemd/system/exos-electrumx.service
	echo "EnvironmentFile=/etc/exos-electrumx.conf" >> /etc/systemd/system/exos-electrumx.service
	echo "ExecStart=/usr/local/bin/electrumx_server" >> /etc/systemd/system/exos-electrumx.service
	echo "User=exos-electrumx" >> /etc/systemd/system/exos-electrumx.service
	echo "LimitNOFILE=8192" >> /etc/systemd/system/exos-electrumx.service
	echo "TimeoutStopSec=30min" >> /etc/systemd/system/exos-electrumx.service
	echo -e "\n[Install]" >> /etc/systemd/system/exos-electrumx.service
	echo "WantedBy=multi-user.target" >> /etc/systemd/system/exos-electrumx.service
}

function exos_conf {
	rm /etc/exos-electrumx.conf
	echo "# default /etc/exos-electrumx.conf for systemd" >> /etc/exos-electrumx.conf
	echo "COIN=EXOS" >> /etc/exos-electrumx.conf
	echo -e "\n# REQUIRED" >> /etc/exos-electrumx.conf
	echo "DB_DIRECTORY = /db-exos" >> /etc/exos-electrumx.conf
	echo "# EXOS Node RPC Credentials" >> /etc/exos-electrumx.conf
	echo "DAEMON_URL = http://yourusernamehere:yourpasswordhere@localhost:4561/" >> /etc/exos-electrumx.conf
	echo -e "\n# See http://electrumx.readthedocs.io/en/latest/environment.html for" >> /etc/exos-electrumx.conf
	echo "# information about other configuration settings you probably want to consider." >> /etc/exos-electrumx.conf
}
