# Automatically generated. Do not edit.
redef Broker::default_port = 27760/tcp;
redef Telemetry::metrics_port = 9991/tcp;
event zeek_init()
	{
	if ( getenv("ZEEKCTL_DISABLE_LISTEN") == "" )
		Broker::listen();
	}
