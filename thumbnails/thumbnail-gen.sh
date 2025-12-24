#!/usr/bin/env bash

frontispieces=(phd deib-phd cs-eng-master classical-master)

for f in "${frontispieces[@]}"; do
    typst c thumbnail-gen.typ "$f".png --input=frontispiece="$f" --pages 1 --ppi 250 --format png 
done

typst c ../examples/executive-summary/executive-summary.typ --root ../  --pages 1 --ppi 250 --format png 
mv ../examples/executive-summary/executive-summary.png .
typst c ../examples/article-format/article-format.typ --root ../  --pages 1 --ppi 250 --format png 
mv ../examples/article-format/article-format.png .

oxipng -o max --fast -Z --strip all *.png
