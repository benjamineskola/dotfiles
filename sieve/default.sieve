require ["fileinto", "regex", "envelope", "subaddress", "variables"];

if anyof (envelope :detail "to" "mendeley",
          envelope :detail "to" "redalert") {

	if header :contains "to" "bma+bytemark@mendeley.com" {
		keep; stop;
	}

	if anyof (header :contains "to" "sysadmin+reports",
	          header :contains "to" "dm-failure-reports",
	          header :contains "to" "web-failure-reports",
	          header :contains "to" "squid-performace-reports") {
		fileinto "mendeley.stats";
		stop;
	}

	if allof (header :contains "from" "Cron Daemon",
	          header :contains "subject" "munin-cron") {
		discard; stop;
	}

	if header :regex "List-Id" ".*" {
		if not header :contains "List-Id" "mendeley.com" {
			fileinto "mendeley.lists";
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
