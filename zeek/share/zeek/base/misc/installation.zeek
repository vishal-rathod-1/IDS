##! This module collects properties of the Zeek installation.
##!
##! Directories are absolute and guaranteed to exist. Not all are necessarily in
##! operational use -- this depends on how you're running Zeek (as a standalone
##! process or clusterized, via zeekctl or the Management framework, etc).
##!
##! For details about Zeek's version, see the :zeek:see:`Version` module.
module Installation;

export {
	## Zeek installation root directory.
	const root_dir = "/opt/zeek";

	## The installation's configuration directory.
	const etc_dir = "/opt/zeek/etc";

	## The installation's log directory.
	const log_dir = "/opt/zeek/logs";

	## The installation's spool directory.
	const spool_dir = "/opt/zeek/spool";

	## The installation's variable-state directory.
	const state_dir = "/opt/zeek/var/lib";
}
