import os
import sys


def from_root(file):
    script_path = os.path.dirname(os.path.realpath(sys.argv[0]))
    return script_path + '/../' + file
