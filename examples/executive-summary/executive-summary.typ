#import "@preview/elegant-polimi-thesis:0.1.2": *

#let data = yaml("../shared_data.yaml")

#show: polimi-executive-summary.with(
  title: [`executive-summary` manual],
  author: data.author,
  advisor: data.advisor,
  coadvisor: data.coadvisor,
  academic-year: data.academic-year,
  language: "en",
)

#show: theorems-init

= Introduction

This document is intended to be both an example of the Polimi Typst template for the Executive Summary of your thesis, as well as a short introduction to its use.

The Executive Summary is required only if the thesis has been assigned to a reviewer (#emph("controrelatore")) for an independent evaluation of its quality, scientific/technical relevance and original contribution.

= Guidelines

The Executive Summary is a critical overview of your thesis
with a focus on the main achievements that have emerged from your research.

The Executive Summary should be organized in sections/paragraphs in order to better highlight the major points of your work.
The length should range from four to six pages depending on the length of the thesis manuscript.
Keep the Executive Summary concise enough to be effective but long enough to allow it to be complete.
It should be written after completing the thesis manuscript as a stand-alone independent document
of sufficient clarity and detail to ensure that the reader can figure out the overall objectives, the methodology employed and the results/impact of your research.

In writing the Executive Summary, keep in mind that it is not an abstract, it is not a preface, and it is not a random collection of highlights.
With a few exceptions, do not simply cut and paste whole sections or paragraphs of the thesis manuscript into a disorganized and cluttered Executive Summary.
You should reorganize information to be informative as well as concise.

The Executive Summary could contain a few important equations related to your work.
It could also include the most relevant figures and tables taken or elaborated from the thesis manuscript.

You should also include in the Executive Summary the very essential bibliography of your study.
The number of selected references should range from three to five depending on the type of work.

The Executive Summary should contain a final section reporting the main conclusions drawn from your research.

= Sections and subsections

It is convenient to organize the Executive Summary of your thesis into sections and subsections.
If necessary, subsubsections, paragraphs and subparagraphs can be also used.
A new section or subsection can be included  with the commands
```typ
= Title of the section
== Title of the subsection
```

It is recommended to give a label to each section by using the command
```typ
= Title of the section<section-name>
```
where the argument is just a text string that you'll use to reference that part
as follows: ```typ @section-name```.

= Equations, Figures, Tables and Algorithms

== Equations

In LaTeX, there are many environments (```tex equation, equation*, aligned```) -- in Typst there is just the equation environment called with dollars @typst-equation:

- Inline math, same as LaTeX:
#columns[
  #set align(center)
  ```Typst
  $a^2 + b^2 = c^2$
  ```
  #colbreak()
  $a^2 + b^2 = c^2$
]

- Block math, by adding whitespaces before and after the content:
#columns[
  #set align(center)
  ```Typst
  $ a^2 + b^2 = c^2 $
  ```
  #colbreak()
  $ a^2 + b^2 = c^2 $
]

Now a more complex equation:

$
  cases(
    Delta dot bold(D) & = rho\,,
    Delta times bold(E) + display((partial bold(B))/(partial t)) & = 0\,,
    Delta dot bold(B) & = 0\,,
    Delta times bold(H) - display((partial bold(D))/(partial t)) & = bold(J).
  )
$

By default, the equations are *not* numbered -- however if you need to:
#math.equation(
  numbering: "(1.1)",
  block: true,
  $
    lr(
      \{
      #block[$                                            Delta dot bold(D) & = rho\, \
      Delta times bold(E) + display((partial bold(B))/(partial t)) & = 0\, \
                                                 Delta dot bold(B) & = 0\, \
      Delta times bold(H) - display((partial bold(D))/(partial t)) & = bold(J). $]
    )
  $,
)<maxwell-equation>

And to reference it just type @maxwell-equation.

== Figures

Via the ```Typst figure``` environment @typst-figure, as you would do in LaTeX:
#figure(image("../../src/img/logo_ingegneria.svg"), caption: [Caption in the List of Figures.])

However, since Typst does not _natively_ support subfigures (see #link("https://github.com/typst/typst/issues/246", "related issue")), the packages smartaref @typst-smartaref and hallon @typst-hallon have been integrated:

#figure(
  grid(
    columns: (1fr, 1fr),
    align: horizon,
    subfigure(
      image("../../src/img/logo_ingegneria.svg", width: 50%),
      caption: [
        Left Polimi logo.
      ],
      label: <a>,
    ),

    subfigure(
      image("../../src/img/logo_ingegneria.svg", width: 50%),
      caption: [
        Right Polimi logo.
      ],
      label: <b>,
    ),
  ),
  caption: [A figure composed of two sub figures, similar to ```latex \subfloat{}```.],
)<full>

You can reference either the main @full; or a single subfigure: @a, or @b.

== Tables

#let frame(color) = (
  (x, y) => (
    left: if x > 0 {
      0pt
    } else {
      color
    },
    right: color,
    top: if y < 2 {
      color
    } else {
      0pt
    },
    bottom: color,
  )
)

#let shading(color) = (
  (x, y) => {
    if y == 0 {
      color
    } else {
      none
    }
  }
)

#show table.cell: it => {
  if (it.x == 0 or it.y == 0) {
    text(weight: "bold", it)
  } else {
    it
  }
}

#set table(align: center)

#figure(
  table(
    columns: 4,
    stroke: frame(black),
    fill: shading(aqua.darken(20%)),
    table.header([], [Column 1], [Column 2], [Column 3]),
    [row 1], [1], [2], [3],
    [row 2], $alpha$, $beta$, $gamma$,
    [row 3], [alpha], [beta], [gamma],
  ),
  caption: [Caption of the Table to appear in the List of Tables.],
)

As you can see, it could be useful to implement a default style for every table @typst-tables.

== Algorithms

For algorithms, there are a lot of packages on Typst universe @typst-universe. The following are my recommendations.

- `lovelace` @typst-lovelace
#import "@preview/lovelace:0.3.0": *

#figure(
  kind: "algorithm",
  supplement: [Algorithm],

  pseudocode-list(booktabs: true, numbered-title: [My cool algorithm])[
    + Initial instructions
    + *for* _for − condition_ *do*
      + Some instructions
      + *if* _if − condition_ *then*
      + Some other instructions
      + *end if*
    + *end for*
    + *while* _while − condition_ *do*
      + Some further instructions
    + *end while*
    + Final instructions
  ],
) <first-algorithm>

See @first-algorithm.

// #pagebreak()

- `algo` @typst-algo
#import "@preview/algo:0.3.6": *

#algo(header: [Name of Algorithm])[
  Initial instructions \
  *for* _for − condition_ *do* #i\
  Some instructions \
  *if* _if − condition_ *then* #i\
  Some other instructions #d\
  *end if* #d\
  *end for* \
  *while* _while − condition_ *do* #i\
  Some further instructions #d\
  *end while* \
  Final instructions
]

= Some further useful recommendations

// theorems and such

How to insert itemized lists:
- first item;
- second item.

How to insert numbered lists:
1. first item;
2. second item.

= Bibliography

The Executive Summary should contain the very essential bibliography of your study. It is suggested to use the BibTeX package LINK and save the bibliographic references in the file
`bibliography.bib`.

= Conclusions

A final section containing the main conclusions of your research/study have to be inserted here.

= Acknowledgements

Here you might want to acknowledge someone.

#bibliography(
  data.bibliography,
  full: true,
)
