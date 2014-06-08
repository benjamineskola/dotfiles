# vim:ft=sieve

require ["fileinto", "regex", "envelope", "subaddress", "variables", "imap4flags"];

if header :contains "X-Spam-Flag" "Yes" {
	setflag "\\Seen";
	if header :regex "X-Spam-Level" "^\\*{10}" {
		fileinto "Junk/Confirmed"; stop;
	}
	fileinto "Junk"; stop;
}

if header :regex "To" "root(@.*|$)" {
	fileinto "root"; stop;
}

if anyof(address :is ["from", "to", "cc"] "bma-bbk@bma.li",
		address :domain :matches ["From", "To", "Cc"] "*bbk.ac.uk",
		address :domain :is ["From", "To", "Cc"] "birkbeckunion.org"
	) {
	fileinto "Birkbeck"; stop;
}

if envelope :localpart :is "to" "bma-bookclub" {
	fileinto "Feminist Book Club";
	stop;
}
