# vim:ft=sieve

require ["fileinto", "regex", "envelope", "subaddress", "variables"];

if header :contains "X-Spam-Flag" "YES" {
	fileinto "spam-possible";
}

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

if envelope :domain :is ["From", "To"] "mendeley.com" {
	if header :contains "to" ["bma+bytemark@mendeley.com", "bma+exonetric@mendeley.com"] {
		keep; stop;
	}

	if anyof (allof (header :contains "from" "Cron Daemon",
	                 header :contains "subject" ["/usr/lib/nagios/plugins/check_http","munin-cron"]),
	          header :contains "to" ["sysadmin+reports","dm-failure-reports","web-failure-reports","squid-performance-reports", "weeklystats", "dailystats", "monthlystats"],
	          header :regex "subject" ["^(\[0-9\]+ )?Debian package update", "/var/www/htdocs/crons/cron.php"]) {
		discard; stop;
	}

	if header :contains ["to","cc"] ["london+funnelfantasy","london+activation","london+retention"] {
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
