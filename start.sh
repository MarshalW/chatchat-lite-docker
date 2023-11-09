#!/bin/bash

tag_file=".installed"

# 检查当前目录下是否有 ".installed" 文件
if [ ! -f $tag_file ]; then
    python3 init_database.py --recreate-vs
    touch $tag_file
fi

python3 startup.py -a --lite