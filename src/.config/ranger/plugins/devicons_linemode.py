import ranger.api
from ranger.core.linemode import LinemodeBase
from plugins.devicons import *

@ranger.api.register_linemode
class MyLinemode(LinemodeBase):
    name = 'devicons'

    def filetitle(self, file, metadata):
        return devicon(file.relative_path) + ' ' + file.relative_path
