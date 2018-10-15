plugin_dir=~/.zsh/plugins
for plugin in ${plugin_dir}/*(/:t); do
	plugin_file=${plugin_dir}/${plugin}/${plugin}.plugin.zsh
	test -f ${plugin_file} && source ${plugin_file}
done
