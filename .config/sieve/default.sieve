# vim:ft=sieve

require ["fileinto", "regex", "envelope", "subaddress", "variables"];

if header :contains "X-Spam-Flag" "YES" {
	fileinto "spam/possible"; stop;
}

if header :regex "List-Id" ".*" {
	fileinto "lists"; stop;
}

if header :regex "To" "root(@.*|$)" {
	fileinto "root"; stop;
}
