# -*- conf -*-

set mbox = +"[gmail].all mail"
set record = +"[gmail].all mail"
set from="Benjamin M. A'Lee <benjamin.a.lee@mendeley.com>"
set timeout=15
set nosig_dashes
set signature="~/.signature.work"

macro index A s>\ny
macro pager A s>\ny

my_hdr Organization: Mendeley

alternates (benjamin.a.lee|bma)@mendeley.com
mailboxes `echo mail/[a-z]* | sed s,mail/,=,g`
