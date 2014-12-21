#!/usr/bin/env python3

import io
import sys


def main():
    if len(sys.argv) < 2 or sys.argv[1] != '-a':
        sys.stderr.write('This tool is not meant to be used directly, use generate_cangjie5_simp.dict.yaml.sh instead.\n')
        return 1
    stdin = io.TextIOWrapper(sys.stdin.buffer, encoding='utf-8')
    stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')
    for line in stdin:
        word, freq = line.strip().split('\t', 1)
        freq = int(freq)
        if len(word) == 1 and freq != 0:
            freq += 10000000
        line = '%s\t%d\n' % (word, freq)
        stdout.write(line)
    return 0


if __name__ == '__main__':
    sys.exit(main())
