#import "@preview/tidy:0.4.3": *
#import "../src/lib.typ"
#import "../src/utils.typ"
#import "@preview/metalogo:1.2.0": LaTeX, TeX

#show "LaTeX": LaTeX

#set page(numbering: "1")
#set enum(numbering: "1.a.i.", indent: 1em)
#set list(indent: 1em)

#align(
  center,
  heading(
    text(size: 1.5em)[`elegant-polimi-thesis` documentation],
    outlined: false,
  ),
)

#v(1em)

This chapter is the result of the documentation generated from the source code. Since it's not strictly needed to use the template -- most of the functions that are to be used are straightforward -- it's quite barebones.

#set heading(numbering: none)

#let toc-block = columns[
  #heading(level: 1, outlined: false, "User designated functions")
  #outline(title: none, depth: 2, indent: 0em)
]

#context block(height: measure(toc-block).height / 2 + 1em, toc-block)

#show-module(
  parse-module(
    read("../src/lib.typ"),
    name: "elegant-polimi-thesis",
    scope: (lib: lib),
    preamble: "#import lib: *\n",
  ),
  style: styles.default,
  first-heading-level: 1,
  show-outline: false,
  show-module-name: false,
  omit-private-definitions: true,
  omit-private-parameters: true,
  sort-functions: none,
)

#v(1cm)

#show-module(
  parse-module(
    read("../src/utils.typ"),
    name: "elegant-polimi-thesis",
    scope: (utils: utils),
    preamble: "#import utils: *\n",
  ),
  style: styles.default,
  first-heading-level: 1,
  show-outline: false,
  show-module-name: false,
  omit-private-definitions: true,
  omit-private-parameters: true,
  sort-functions: none,
)
