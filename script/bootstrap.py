#!/usr/bin/env python

import os
import json
import path
import tempfile

from platform import detect_platform
from config import setup_files


def install_packages():
    plt, dist = detect_platform()

    with open(path.from_root('platform/%s-%s/packages.json' % (plt, dist)),
              'r') as pkg_file:
        pkg_json = json.loads(pkg_file.read())

    # Install packages first
    if pkg_json['install_cmd'].count('{{package}}') > 0:
        for pkg in pkg_json['packages']:
            cmd = pkg_json['install_cmd'].replace('{{package}}', pkg)
            os.system(cmd)
    elif pkg_json['install_cmd'].count('{{packages}}') > 0:
        pkg_list = ''
        for pkg in pkg_json['packages']:
            pkg_list += pkg + ' '
        cmd = pkg_json['install_cmd'].replace('{{packages}}', pkg_list)
        os.system(cmd)

    # Next run any custom builds
    for build in pkg_json['build']:
        if not os.path.isfile(build['check_file']):
            continue

        tmpcmd = tempfile.NamedTemporaryFile(delete=False)
        for cmd in build['commands']:
            tmpcmd.write('%s\n' % cmd)
        tmpcmd.close()

        os.chmod(tmpcmd.name, 0o755)
        os.system(tmpcmd.name)

        os.remove(tmpcmd.name)


if __name__ == '__main__':
    install_packages()
    setup_files()
