# vim:ft=sieve

require ["fileinto", "regex", "envelope", "subaddress", "variables"];

if header :contains "X-Spam-Flag" "YES" {
	fileinto "spam/possible";
}

if header :regex "List-Id" ".*" {
	if allof (not envelope :detail "to" "lists",
	          envelope :regex "to" "-(.*)@") {
		fileinto "lists/${1}";
		stop;
	}
	fileinto "lists"; stop;
}
