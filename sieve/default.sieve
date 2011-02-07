require ["fileinto", "regex", "envelope", "subaddress", "variables"];

if header :regex "List-Id" ".*" {
	if not header :contains "List-Id" "mendeley.com" {
		if allof (not envelope :detail "to" "lists",
		          envelope :regex "to" "-(.*)@") {
			fileinto "lists/${1}";
			stop;
		}
		fileinto "lists"; stop;
	}
}

if anyof (envelope :detail "to" "mendeley",
          envelope :detail "to" "redalert") {

	if header :contains "to" "bma+bytemark@mendeley.com" {
		keep; stop;
	}

	if anyof (allof (header :contains "from" "Cron Daemon",
	                 header :contains "subject" ["/usr/lib/nagios/plugins/check_http","munin-cron"]),
	          header :contains "to" ["sysadmin+reports","dm-failure-reports","web-failure-reports","squid-performance-reports"],
	          header :regex "from" "nagios@monitor.*\.mendeley\.com",
	          header :regex "subject" "^Debian package updates?") {
		discard; stop;
	}

	if header :contains "from" "trac@office.mendeley.com" {
		fileinto "mendeley/trac";
		stop;
	}

	if header :regex ["to","cc"] ".*+(social|info|hackday)@mendeley\.com" {
		fileinto "mendeley/social";
		stop;
	}

	if header :regex "to" "^redalert+.*" {
		fileinto "mendeley/redalert";
		stop;
	}

	fileinto "mendeley";
	stop;
}

