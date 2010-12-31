require ["fileinto", "regex" ];
if header :regex "List-Id" ".*" { fileinto "lists"; stop; }
