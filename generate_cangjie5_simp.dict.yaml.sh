#!/bin/bash

set -e
if [ ! -e essay.txt ]
then
    echo "找不到八股文词库文件 essay.txt" >&2
    echo "请从此处下载：" >&2
    echo "https://github.com/lotem/brise/blob/master/essay.txt?raw=true" >&2
    exit 2
fi
cat >cangjie5_simp.dict.yaml <<EOM
# encoding: utf-8
# 本词库由中州韻输入法引擎之八股文词库经 OpenCC 转换，设为简体仓颉输入法使用。
# 原版八股文词库: https://github.com/lotem/brise/blob/master/essay.txt
---
name: "cangjie5_simp"
version: "0.18"
use_preset_vocabulary: false
import_tables:
  - cangjie5
columns:
  - text
  - weight
sort: by_weight
max_phrase_length: 7
min_phrase_weight: 100
encoder:
  exclude_patterns:
    - '^x.*$'
    - '^z.*$'
  rules:
    - length_equal: 2
      formula: "AaAzBaBbBz"
    - length_equal: 3
      formula: "AaAzBaBzCz"
    - length_in_range: [4, 10]
      formula: "AaBzCaYzZz"
  tail_anchor: "'"
...

EOM
opencc -c zht2zhs.ini -i essay.txt >>cangjie5_simp.dict.yaml
echo "词库文件 cangjie5_simp.dict.yaml 已创建。" >&2
