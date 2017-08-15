from mercurial import cmdutil
from mercurial import commands

cmdtable = {}
command = cmdutil.command(cmdtable)

@command('show', [], '[revision]')
def show(ui, repo, revision='.', **opts):
    commands.log(ui, repo, rev=revision, limit=1, patch=True)
