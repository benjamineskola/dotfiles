# vim:ft=sieve

require ["fileinto", "regex", "envelope", "subaddress", "variables"];

if header :regex "From" "@astoncarter.co.uk" {
	fileinto "spam"; stop;
}

if header :contains "X-DSPAM-Result" "Spam" {
	if header :regex "X-DSPAM-Confidence" "^(1|0.([89]|7[5-9]))" {
		fileinto "spam"; stop;
	}
	fileinto "spam/possible"; stop;
}

if header :regex "To" "root(@.*|$)" {
	fileinto "root"; stop;
}

if header :regex "To" ".*@bmalee.eu" {
	fileinto "bmalee.eu"; stop;
}

if header :regex "To" ".*@bma.cx" {
	fileinto "bma.cx"; stop;
}

if header :regex "To" ".*@.*subvert.org.uk" {
	fileinto "subvert.org.uk"; stop;
}

if anyof(address :is ["from", "to", "cc"] "bma-bbk@bma.li",
		address :domain :matches ["From", "To", "Cc"] "*bbk.ac.uk",
		address :domain :is ["From", "To", "Cc"] "birkbeckunion.org"
	) {
	fileinto "Birkbeck"; stop;
}

if header :regex "List-Id" ".*" {
	fileinto "lists"; stop;
}
