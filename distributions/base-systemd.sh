function install_init {
	if [ ! -d /etc/systemd/system ]; then
		_error "/etc/systemd/system does not exist. Is systemd installed?" 8
	fi
	cp /tmp/electrumx-civx/contrib/systemd/electrumx-civx.service /etc/systemd/system/electrumx-civx.service
	cp /tmp/electrumx-civx/contrib/systemd/electrumx-civx.conf /etc/
	if [ $USE_ROCKSDB == 1 ]; then
		echo -e "\nDB_ENGINE=rocksdb" >> /etc/electrumx-civx.conf
	fi
	systemctl daemon-reload
	systemctl enable electrumx-civx
	systemctl status electrumx-civx
	_info "Use service electrumx-civx start to start electrumx-civx once it's configured"
}
