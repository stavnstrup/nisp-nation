#!/bin/sh

mv node_modules save-node_modules
git clean -Xfd
mv save-node_modules node_modules
