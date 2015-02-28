#!/usr/bin/env python

import os
import sys
import json
import subprocess
import re

overwrite_all = False

re_include = re.compile(r'{{include\s(?P<path>[\w/{}\.]+)}}', re.IGNORECASE)


# Sets up any symlinks in the files directory
def setup_files(source=None, dest=None):

    global overwrite_all

    source = source or os.path.realpath(
        os.path.join(
            os.path.dirname(os.path.realpath(__file__)),
            '../files'
        )
    )
    dest = dest or os.path.expanduser('~')

    if not os.path.exists(source):
        return False

    if not os.path.exists(dest):
        return False

    item = os.path.basename(source)
    processed_paths = {}

    cur_config = None
    cfg_vars = {}
    cfg_merge = []
    cur_cfg_path = os.path.join(source, 'dotconfig.json')
    if os.path.isfile(cur_cfg_path):
        print('Reading config %s' % cur_cfg_path)
        with open(cur_cfg_path, 'r') as cur_cfg_file:
            cur_config = json.loads(cur_cfg_file.read())
            cfg_vars = expand_vars(
                cur_config.get('vars', {}),
                source
            )

            cfg_merge = cur_config.get('merge', [])

    for merge in cfg_merge:
        m_out = replace_vars(cfg_vars, merge['output'])
        out_path = os.path.join(source, m_out)
        print('Merging %s' % out_path)

        with open(out_path, 'w') as f_out:
            for m_in in merge['input']:
                in_path = os.path.join(source, replace_vars(cfg_vars, m_in))

                in_content = process_file(in_path, cfg_vars, source)

                f_out.write('%s\n' % in_content)

    if source.endswith('.symlink'):
        sym_from = source
        sym_to = os.path.join(dest, '.'+item[:-8])

        if cur_config:
            sym_section = cur_config.get('symlink')
            if sym_section is not None:
                sym_root = sym_section['root']
                new_root = os.path.expanduser(
                    os.path.join('~', sym_root)
                )
                if not os.path.exists(new_root):
                    os.mkdir(new_root)

                sym_to = os.path.join(new_root, item[:-8])

        sym_from = sym_from.strip()
        sym_to = sym_to.strip()

        if os.path.lexists(sym_to):
            if overwrite_all:
                os.remove(sym_to)
            else:
                sys.stdout.write(
                    'File exists (%s), overwrite? ([y]es/[a]ll/[n]o) ' % sym_to)
                sys.stdout.flush()
                confirmation = sys.stdin.readline().strip().lower()

                if confirmation == 'y':
                    os.remove(sym_to)
                elif confirmation == 'a':
                    overwrite_all = True
                    os.remove(sym_to)
                else:
                    return False

        print('Symlinking %s to %s' % (sym_from, sym_to))
        os.symlink(sym_from, sym_to)

        if os.path.isdir(source):
            for item in os.listdir(source):
                p = os.path.join(source, item)
                res = setup_files(p, dest)
                if not res:
                    return False

        return True

    elif os.path.isdir(source):
        for item in os.listdir(source):
            p = os.path.join(source, item)
            res = setup_files(p, dest)
            if not res:
                return False

    return True


def process_file(file_path, cfg_vars, base_path):
    with open(file_path, 'r') as f_in:
        in_content = ''.join(f_in.readlines())
        in_content = replace_vars(cfg_vars, in_content)

        inc_matches = re_include.finditer(in_content)
        if inc_matches:
            for inc_match in inc_matches:
                inc_path = os.path.join(base_path,
                                        inc_match.group('path'))
                with open(inc_path, 'r') as f_inc:
                    in_content = re.sub(
                        inc_match.group(0),
                        ''.join(f_inc.readlines()),
                        in_content
                    )

    return in_content


def expand_vars(vars, path):
    ret = {}

    for var in vars:
        val = var.get('value')
        if val:
            ret[var['name']] = val
            continue

        exec_cmd = var.get('exec')
        if exec_cmd:
            try:
                out_val = subprocess.check_output(
                    ('cd %s;' % path) + var['exec'], shell=True)
                ret[var['name']] = out_val.decode('utf-8').strip()
                continue

            except subprocess.CalledProcessError:
                print('Unable to set variable: %s = %s' %
                      (var['name'], var['exec']))
                sys.exit(1)

        ret[var['name']] = ''

    return ret


def replace_vars(vars, input):
    for var_name in vars:
        input = re.sub('{{%s}}' % var_name, vars[var_name], input)
    return input

if __name__ == '__main__':
    setup_files()
