require ["fileinto", "regex", "envelope", "subaddress"];

if anyof (envelope :detail "to" "mendeley",
          envelope :detail "to" "redalert") { fileinto "mendeley"; stop; }

if header :regex "List-Id" ".*" { fileinto "lists"; stop; }
