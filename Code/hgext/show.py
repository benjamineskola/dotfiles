from mercurial import registrar
from mercurial import commands
from mercurial import logcmdutil

cmdtable = {}
command = registrar.command(cmdtable)

@command('show', [], '[revision]')
def show(ui, repo, revision='.', **opts):
    revision, differ = logcmdutil.getrevs(repo, [], {'rev':[revision]})
    commands.log(ui, repo, rev=revision, limit=1, patch=True)
