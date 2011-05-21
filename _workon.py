#!/usr/bin/env python
import os
import sys
from fabric.api import local

PROJECT_ROOTS = {
        'webapp': os.path.abspath('/opt/webapps'),
        'sandbox': os.path.abspath('/home/yml/workdir/sandbox')
        }


class ProjectNotFoundException(Exception):
    pass


class WorkonProject(object):
    """
    This class is responsible for all work to 
    find and activate the virtualenv in a project.
    """
    def __init__(self, project):
        self.project = project
        self.project_dir = self._project_lookup()
        self.activation_file = self._activation_file() or None

    def _project_lookup(self):
        """This function lookup for the project you
        want to work on.
        It return the complete path to the project
        """
        if os.path.isdir(self.project):
            return os.path.abspath(self.project)
        else:
            for project_root in PROJECT_ROOTS.values():
                if os.path.isdir(os.path.join(project_root, self.project)):
                    return os.path.join(project_root, self.project)
        raise ProjectNotFoundException

    def _activation_file(self):
        """
        This method return the path to the file that can activate the env
        if it exists

        @param project_dir is the path of the project containning the venv
        """
        activate_file = os.path.join(self.project_dir, 'bin', 'activate')
        if os.path.isfile(activate_file):
            return activate_file


def main():
    project = sys.argv[1]
    wp = WorkonProject(project)
    print('%s,%s' % (wp.project_dir, wp.activation_file))

if __name__ == '__main__':
    main()
