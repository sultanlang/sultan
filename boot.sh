#!/bin/sh


cd compiler/boot

ocamlc -c progress.ml
ocamlc -c builder.ml



ocamlc  -o boost  progress.cmo builder.cmo
./boost 



