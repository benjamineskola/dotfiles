require ["fileinto", "regex", "envelope", "subaddress", "variables"];

if anyof (envelope :detail "to" "mendeley",
          envelope :detail "to" "redalert") {

	if header :contains "to" "bma+bytemark@mendeley.com" {
		keep; stop;
	}

	if allof (header :contains "from" "Cron Daemon",
	          anyof (header :contains "subject" "/usr/lib/nagios/plugins/check_http",
		         header :contains "subject" "munin-cron")) {
		discard; stop;
	}

	if anyof (header :contains "to" "sysadmin+reports",
	          header :contains "to" "dm-failure-reports",
	          header :contains "to" "web-failure-reports",
	          header :contains "to" "squid-performace-reports") {
		fileinto "mendeley/stats";
		stop;
	}

	if header :regex "to" ".*+social@mendeley\.com" {
		fileinto "mendeley/social";
		stop;
	}

	if header :regex "from" "nagios@monitor.*\.mendeley\.com" {
		fileinto "mendeley/nagios";
		stop;
	}

	if header :regex "to" "^redalert+.*" {
		fileinto "mendeley/redalert";
		stop;
	}

	if header :regex "subject" "^Debian package updates?" {
		fileinto "mendeley/pkgupdate";
		stop;
	}

	if header :regex "List-Id" ".*" {
		if not header :contains "List-Id" "mendeley.com" {
			fileinto "mendeley/lists";
			stop;
		}
	}

	fileinto "mendeley";
	stop;
}

if header :regex "List-Id" ".*" {
	if allof (not envelope :detail "to" "lists",
	          envelope :regex "to" "-(.*)@") {
		fileinto "lists/${1}";
		stop;
	}
	fileinto "lists"; stop;
}
