# -*- coding: utf-8 -*-
"""
Created on Sat Sep 17 14:26:06 2016

@author: chizhi
"""
import re

fhand = open('POB')
text_parsed = []
for line in fhand:
    line = re.sub('^0+', '', line)
    line = re.sub('\n', '', line)
    text_parsed.append(re.split('\s\.', line))

with open('pobp.txt', 'w') as f:
    for line in text_parsed:
        for element in line:
                f.write('%s\t' % element)
        f.write('\n')
f.close()