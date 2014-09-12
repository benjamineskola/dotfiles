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

if anyof(address :detail :is ["to", "cc"] ["bbk", "birkbeck"],
		address :localpart :is ["to", "cc"] "bma-bbk",
		address :domain :matches ["From", "To", "Cc"] "*bbk.ac.uk",
		address :domain :is ["From", "To", "Cc"] "birkbeckunion.org"
	) {
	fileinto "Birkbeck"; stop;
}

if header :is "List-Id" "<intersectional-feminist-book-club.googlegroups.com>" {
	fileinto "Feminist Book Club";
	stop;
}

if header :is "List-Id" "UK FreeBSD Users <ukfreebsd.uk.freebsd.org>" {
	fileinto "UK FreeBSD";
	stop;
}
