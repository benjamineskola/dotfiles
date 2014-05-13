# vim:ft=sieve

require ["fileinto", "regex", "envelope", "subaddress", "variables", "imap4flags"];

if address :domain :is "From" "astoncarter.co.uk" {
	setflag "\\Seen";
	fileinto "Junk/Confirmed"; stop;
}

if allof(address :domain :is "From" "refuge.org.uk",
	header :is "To" "bma@subvert.org.uk") {
	setflag "\\Seen";
	fileinto "Deleted Messages"; stop;
}

if header :contains "X-DSPAM-Result" "Spam" {
	setflag "\\Seen";
	if header :regex "X-DSPAM-Confidence" "^(1|0.([89]|7[5-9]))" {
		fileinto "Junk/Confirmed"; stop;
	}
	fileinto "Junk"; stop;
}

if header :regex "To" "root(@.*|$)" {
	fileinto "root"; stop;
}

#if header :regex ["to", "cc"] ".*@.*(bmalee.eu|bma.cx|subvert.org.uk)" {
	#fileinto "Old/${1}"; stop;
#}

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
#if envelope :localpart :is "to" ["bma-hackspace", "bma-newhamcyclist", "bma-fosdem"] {
#	setflag "\\Seen"; fileinto "Deleted Messages"; stop;
#}
#if header :regex "List-Id" ".*" {
#	fileinto "lists"; stop;
#}
#
#if address :detail "to" "bha" {
#	fileinto "lists"; stop;
#}
