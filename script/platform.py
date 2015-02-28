import os


def detect_platform():
    if os.path.isfile('/etc/debian_release'):
        return 'linux', 'debian'
    elif os.path.isfile('/etc/arch-release'):
        return 'linux', 'arch'
