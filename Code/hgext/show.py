from mercurial import registrar
from mercurial import commands

cmdtable = {}
command = registrar.command(cmdtable)

@command('show', [], '[revision]')
def show(ui, repo, revision='.', **opts):
    commands.log(ui, repo, rev=revision, limit=1, patch=True)
