# Automatically generated. Do not edit.
redef Notice::mail_dest = "root@localhost";
redef Notice::mail_dest_pretty_printed = "root@localhost";
redef Notice::sendmail = "/usr/sbin/sendmail";
redef Notice::mail_subject_prefix = "[Zeek]";
redef Notice::mail_from = "Zeek <zeek@kali>";
redef Broker::table_store_db_directory = "/opt/zeek/spool/brokerstore";
redef Log::default_rotation_interval = 3600 secs;
redef Log::default_mail_alarms_interval = 86400 secs;
redef Pcap::snaplen = 9216;
redef Pcap::bufsize = 128;
redef global_hash_seed = "5a5597bb";
redef Cluster::default_store_dir = "/opt/zeek/spool/stores";
redef FileExtract::prefix = "/opt/zeek/spool/extract_files/" + Cluster::node;
