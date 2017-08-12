#!/bin/bash

hugo

cd /public
git add .
git commit -m "update my blog"
git push