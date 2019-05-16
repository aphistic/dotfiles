import os


def detect_platform():
    if os.path.isfile('/etc/debian_release') or \
       os.path.isfile('/etc/debian_version'):
        return 'linux', 'debian'
    elif os.path.isfile('/etc/arch-release'):
        return 'linux', 'arch'
