= Chapter one

In this section there will be useful information about how to style chapters, sections and so on.

== Sections and subsection

#import "@preview/metalogo:1.2.0": TeX, LaTeX

#let typst = {
  text(
    fill: eastern,
    font: "Libertinus Serif",
    "typst",
  )
}

In #LaTeX, the canonical sections division is as follows:
```tex
\chapter{}
\section{}
\subsection{}
\subsubsection{}
```
in #typst, there are just headings (similarly to Markdown) -- so the #LaTeX system maps to:
```typst
= Chapter           // Heading level 1
== Section          // Heading level 2
=== Subsection      // Heading level 3
==== Subsubsection  // Heading level 4
```

If you need to turn off the numbering you will call the ```typst heading``` function:
```typst
#heading("Heading Title", level: n, numbering: none)
```

== Equations

In #LaTeX, there are many envinroments (```tex equation, equation*, aligned```) -- in #typst there is just the equation envinroment called with dollars:
- Inline math, same as #LaTeX:
#columns[
  #set align(center)
  ```typst
  $a^2 + b^2 = c^2$
  ```
  #colbreak()
  $a^2 + b^2 = c^2$
]

- Block math, by adding separating with spaces:
#columns[
  #set align(center)
  ```typst
  $ a^2 + b^2 = c^2 $
  ```
  #colbreak()
  $ a^2 + b^2 = c^2 $
]

For a more complex equation:
```tex
  \begin{subequations}
    \label{eq:maxwell}
    \begin{align}[left=\empheqlbrace]
    \nabla\cdot \bm{D} & = \rho, \label{eq:maxwell1} \\
    \nabla \times \bm{E} +  \frac{\partial \bm{B}}{\partial t} & = \bm{0}, \label{eq:maxwell2} \\
    \nabla\cdot \bm{B} & = 0, \label{eq:maxwell3} \\
    \nabla \times \bm{H} - \frac{\partial \bm{D}}{\partial t} &= \bm{J}. \label{eq:maxwell4}
    \end{align}
\end{subequations}
```
```typst
$
  cases(
    Delta dot bold(D) &= rho\, \
    Delta times bold(E) + display((partial bold(B))/(partial t)) &= 0\, \
    Delta dot bold(B) &= 0\, \
    Delta times bold(H) - display((partial bold(D))/(partial t)) &= bold(J).
  )
$
```
$
  cases(
    Delta dot bold(D) &= rho\, \
    Delta times bold(E) + display((partial bold(B))/(partial t)) &= 0\, \
    Delta dot bold(B) &= 0\, \
    Delta times bold(H) - display((partial bold(D))/(partial t)) &= bold(J).
  )
$

By default, the equations are *not* numbered -- however if you need to:
#math.equation(
  numbering: "(1.1)",
  block: true,
  $
    cases(
      Delta dot bold(D) &= rho\, \
      Delta times bold(E) + display((partial bold(B))/(partial t)) &= 0\, \
      Delta dot bold(B) &= 0\, \
      Delta times bold(H) - display((partial bold(D))/(partial t)) &= bold(J).
    )
  $,
)<maxwell-equation>

And to reference it just type @maxwell-equation.

== Figures, Tables and Algorithms

=== Figures

#figure(
  image("../../src/img/logo_ingegneria.svg"),
  caption: [Caption in the List of Figures.],
)

As of April 11th, 2025 there is no support for subfigures.

=== Tables

The default table has been implemented:

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
  caption: [Caption of the Table ot appear in the List of Tables],
)

As you can see, it could be useful to implement a default style for every table.

=== Algorithms

For algorithms, there are some packages recommened:
- algo
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

- lovelace
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

== Theorems, propositions and lists

#import "@local/polimi-phd-thesis:1.0.0": *
// #import "@preview/ctheorems:1.1.3": *
// #let theorem = thmbox("theorem", "Theorem")
// #let corollary = thmplain(
//   "corollary",
//   "Corollary",
//   base: "theorem",
//   titlefmt: strong,
// )
// #let definition = thmbox("definition", "Definition", inset: (x: 1.2em, top: 1em))

// #let example = thmplain("example", "Example").with(numbering: none)
// #let proof = thmproof("proof", "Proof")

#theorem[
  Write here you theorem.
]

#proof[
  If useful you can report here the proof.
]

#proposition[
  Write here you theorem.
]

#proof[
  If useful you can report here the proof.
]

Normal list:
- First item
- Second item

Numbered list:
+ First item
+ Second item

== Plagiarism

You have to be sure to respect the rules on Copyright and avoid an involuntary plagia-
rism. It is allowed to take other persons’ ideas only if the author and his original work are clearly mentioned. As stated in the Code of Ethics and Conduct, Politecnico di Milano promotes the integrity of research, condemns manipulation and the infringement of intellectual property, and gives opportunity to all those who carry out research activities to have an adequate training on ethical conduct and integrity while doing research. To be sure to respect the copyright rules, read the guides on Copyright legislation and citation styles available at:

#link("https://www.biblio.polimi.it/en/tools/courses-and-tutorials")

You can also attend the courses which are periodically organized on "Bibliographic cita-
tions and bibliography management".

== Bibliography and citations
Your thesis must contain a suitable Bibliography which lists all the sources consulted on developing the work. The list of references is placed at the end of the manuscript after the chapter containing the conclusions. We suggest to use the BibTeX package and save the
bibliographic references in the file Thesis_bibliography.bib. This is indeed a database
containing all the information about the references.

To cite in your manuscript, use the `cite` command as follows:

#align(
  center,
  emph(
    [Here is how you cite bibliography entries: @knuth74 or #cite(<knuth92>).]
  )
)

As of now, there is no support to multiple citations. As it would have been in #LaTeX, the bibliography is automatically generated.
