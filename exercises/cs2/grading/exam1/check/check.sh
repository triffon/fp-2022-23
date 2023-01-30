#!/bin/bash

if [ $# -lt 1 ]; then
        echo 'Usage: ./check.sh <filepath>'
        exit 1
fi

dir=$(dirname $0)

if [ "${1##*.}" = hs ]
then
  cat $1 $dir/checks.hs > $dir/temp.hs
  runhaskell $dir/temp.hs
else
  racket <(echo '#lang racket'
           cat $1 $dir/describe.rkt $dir/checks.rkt \
             | grep -vE '#lang racket|\(require "describe.rkt"\)')
fi
