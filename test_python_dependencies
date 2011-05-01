#!/usr/bin/env python
# -*- encoding: utf-8 -*-
"""Checks for dependencies of the various Python programs

Note that we only check these files in this directory; we don't do transitive
dependency testing.  So if you have all of the dependencies listed here, but 
not *their* dependencies, then things could still break on you.  Hopefully it 
will break so spectacularly that you notice right away.


Copyright (c) 2011 Joe Blaylock <jrbl@jrbl.org>
Licensed (at your choice) under the GNU GPL2, any later GNU GPL, or BSD

FIXME: put correct legalese here
"""

# These imports should be safe, as they're part of every Python installation
import pprint
import os
import sys
import re


def ignore(filename):
    """Should we ignore this filename?

    True for all *.bak, *.orig, *~, .*, and *.*.[0-9]
    """
    ignore_list = [
           '.+\.bak$',
           '.+\.orig$',
           '.+~$',
           '^\..+',
           '.+\..+\.[0-9]$',
    ]
    for ignoretype in ignore_list:
        if re.match(ignoretype, filename):
            return True
    return False


def is_python(filename):
    """To the best of our knowledge, is this a Python file?"""
    if re.match('.+\.py$', filename):
        return True
    shebang = open(filename, 'r').readline()
    if re.match('\#\!.+python$', shebang):
        return True
    return False


def get_dependencies(filename):
    """Try to gather all the imports out of a file (presumed to be python)

    FIXME: Doesn't deal with import split over multiple lines by ending with \\
    """
    deps = []
    for line in open(filename, 'r'):
        possible_dep = line.strip()
        m = re.match('^import ((?P<dep>.+),?)+', possible_dep)
        if m:
            for group in m.groups():
                deps.extend([i.strip() for i in group.split(',')])
            continue
        m = re.match('^from (?P<prefix>.+) import ((?P<dep>.+),?)+', possible_dep)
        if m:
            prefix = m.group('prefix')
            for dep in m.groupdict()['deps']:
                deps.extend([prefix + '.' + i.strip() for i in dep.split(',')])
    return deps


def print_unmet_dependency_report(unmet):
    """Nicely list out all of our unmet dependencies"""
    pprint.pprint(unmet)


def main(directory):
    deps = []
    unmet = []
    files = os.listdir(directory)
    for file in files:
        if ignore(file):
            continue
        if is_python(file):
            deps.extend(get_dependencies(file))
    
    for dep in sorted(list(set(deps))):
        try:
            exec 'import %s' % dep
        except:                        # I don't care why they don't work
            unmet.append(dep)

    if len(unmet):
        print_unmet_dependency_report(unmet)
        sys.exit(1)
    else:
        print "Everything looks OK!"
        sys.exit(0)


if __name__ == "__main__":
    argv = sys.argv
    argc = len(argv)
    if argc == 1:
        main('.')
    else:
        for arg in argv[1:]:
            main(arg)
