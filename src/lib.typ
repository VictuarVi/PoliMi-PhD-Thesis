#let sizes = (
  tiny: 0.5em,
  scriptsize: 0.7em,
  footnotesize: 0.8em,
  small: 0.9em,
  normalsize: 1em,
  large: 1.2em,
  Large: 1.44em,
  LARGE: 1.728em,
  huge: 2.074em,
  Huge: 2.488em,
)

#let document-state = state("TITLE_PAGE", true)

#let localization = yaml("locale.yaml")

#let bluepoli = rgb("#5f859f")

#let polimi_thesis(
  title: "Thesis Title",
  author: "Name Surname",
  advisor: "Advisor",
  coadvisor: "Coadvisor",
  tutor: "Tutor",
  phdcycle: "", // {Year ... - ... Cycle}
  cycle: none,
  chair: none,
  language: "en",
  colored-heading: true,
  main_logo: "../img/logo_ingegneria.svg",
  body,
) = {
  set document(
    title: title,
    author: author,
  )

  set text(
    lang: language,
    size: 12pt,
    font: "New Computer Modern",
  )
  show math.equation: set text(font: "New Computer Modern Math")
  set par(
    justify: true,
    linebreaks: "optimized",
  )

  set page(
    paper: "a4",
    margin: (
      top: 2.5cm,
      bottom: 2.5cm,
      inside: 3.0cm,
      outside: 2.0cm,
    ),
    numbering: "i",
    header: context {
      if (
        document-state.get() == "TITLE_PAGE"
      ) {
        none
      } else if (
        document-state.get() == "FRONTMATTER"
          or document-state.get() == "ACKNOWLEDGEMENTS"
          or document-state.get() == "BACKMATTER"
          or document-state.get() == "APPENDIX"
      ) {
        if (calc.even(here().page())) {
          counter(page).display()
          h(1fr)
        } else {
          h(1fr)
          counter(page).display()
        }
      } else if (
        document-state.get() == "MAINMATTER"
      ) {
        let isThereH1 = query(heading.where(level: 1)).filter(h1 => h1.location().page() == here().page())
        let before = query(selector(heading.where(level: 1)).before(here()))

        let output = if not (isThereH1.len() != 0) {
          set text(weight: "bold")
          text(
            fill: if (colored-heading) { bluepoli },
            counter(heading.where(level: 1)).display() + "| ",
          )
          before.last().body
        }

        if (calc.even(here().page())) {
          counter(page).display()
          h(1fr)
          output
        } else {
          output
          h(1fr)
          counter(page).display()
        }
      }
    },
    footer: { },
  )

  // FIGURE

  // Didascalia delle figure
  let figure_number = counter("figure_counter")
  figure_number.step()
  show figure.caption: it => context {
    let heading_num = counter(heading).get().first()
    figure_number.step()
    text(
      weight: "bold",
      fill: if (colored-heading) { bluepoli },
      {
        it.supplement
        if it.numbering != none {
          [ ]
          str(heading_num)
          [.]
          // it.counter.display(it.numbering)
          figure_number.display()
        }
      },
    )
    [: ]
    it.body
  }

  // Theorems.
  let theorem_number = counter("theorem_counter")
  show figure.where(kind: "theorem"): it => block(
    above: 11.5pt,
    below: 11.5pt,
    {
      strong({
        it.supplement
        if it.numbering != none {
          [ ]
          counter(heading).display()
          [.]
          it.counter.display(it.numbering)
        }
      })
      [ --]
      emph(it.body)
    },
  )

  // --------------------- [ TITOLAZIONE ] ---------------------
  // Logo
  v(0.6fr)
  place(
    dx: 44%,
    dy: -28%,
    image("../img/raggiera_chiara.svg", width: 90%),
  )
  place(
    dx: 1.5%,
    dy: -1%,
    image(main_logo, width: 73%),
  )

  v(4.20fr)

  // Titolazione
  text(
    size: sizes.huge,
    weight: 700,
    fill: if (colored-heading) { bluepoli },
    title,
  )
  // v(1.2em, weak: true)
  // text(1.1em, style: "italic", subtitle)

  v(1.5cm)

  align(end)[
    #set text(size: sizes.Large)
    Doctoral Dissertation of: \
    *#author*
  ]

  v(1fr)

  if (phdcycle == "") {
    phdcycle = str(datetime.today().year()) + " - " + str(datetime.today().year() + 1)
  }

  align(start)[
    #set text(size: sizes.large)
    Advisor: Prof. #advisor \
    Coadvisor: Prof. #coadvisor \
    Tutor: Prof. #tutor \
    Year #phdcycle Cycle
  ]

  // Document

  show heading: it => {
    if (colored-heading) {
      text(fill: bluepoli, it)
    }
  }
  // --------------------- [ STILE DEI CAPITOLI ] ---------------------

  let raggera = {
    v(1fr)
    place(
      dx: -7cm,
      dy: -16.25cm,
      image(
        "../img/raggiera_chiara.svg",
        width: 0.85 * 24cm,
      ),
    )
  }

  show heading.where(level: 1): it => context {
    // checks if the page is empty: the cursor is at the same length from the top as the top margin
    if (calc.even(here().page()) and here().position().y.cm() == page.margin.top.length.cm()) {
      set page(header: { })
      phantom-content
    } else if (calc.odd(here().page()) and here().position().y.cm() == page.margin.top.length.cm()) { } else if (
      calc.odd(here().page())
    ) {
      set page(header: { }, background: raggera)
      pagebreak(to: "odd")
    }
    // v(120pt)
    v(4cm)
    let heading-num = counter(selector(heading)).display()
    if (document-state.get() == "MAINMATTER") {
      text(
        size: sizes.Huge,
        weight: "bold",
        fill: if (colored-heading) { bluepoli },
        heading-num + "| ",
      )
    }
    text(
      size: sizes.Large,
      weight: "bold",
      fill: if (colored-heading) { bluepoli },
      it.body,
    )
    v(10pt)

    // reset contatori
    // counter(figure.where(kind: "image")).update(0)
    figure_number.update(0)
    counter(figure.where(kind: "table")).update(0)
    counter(figure.where(kind: "theorem")).update(0)
  }

  show heading: it => context {
    if (it.level == 1) {
      it
    } else if (it.level == 2) {
      text(size: 1.25em, it)
    } else if (it.level >= 3) {
      it
    }
  }

  // ----------- [ TABLE OF CONTENTS ] -----------
  // I Capitoli sono in grassetto e non hanno le righe
  show outline.entry.where(level: 1): it => context {
    v(19pt, weak: true)
    link(
      it.element.location(),
      strong(it.indented(it.prefix(), it.element.body + h(1fr) + it.page())),
    )
  }

  show outline.entry: it => {
    if it.level > 1 {
      v(1em, weak: true)
      let spacing = it.level - 1
      h(2em) * spacing
      link(it.element.location(), it)
    } else {
      link(it.element.location(), it)
    }
  }

  show figure.where(kind: "lists"): it => {
    align(start, it.body)
  }

  // pagebreak()
  body
}

// Document sections
#let frontmatter(body) = {
  document-state.update("FRONTMATTER")
  // counter(page).update(0)
  set page(numbering: "i")
  set heading(numbering: none)

  body
}

#let acknowledgements(body) = {
  document-state.update("ACKNOWLEDGEMENTS")

  body
}

#let mainmatter(body) = {
  document-state.update("MAINMATTER")
  set heading(numbering: "1.1")
  set page(numbering: "1")
  counter(page).update(0)

  body
}

#let appendix(body) = context {
  document-state.update("APPENDIX")
  counter(heading).update(0)
  set heading(numbering: "A.1")

  body
}

#let backmatter(body) = context {
  document-state.update("BACKMATTER")
  set heading(numbering: none)

  body
}

// Table of contents

#let target = (
  figure
    .where(
      kind: "lists",
      outlined: true,
    )
    .or(heading.where(outlined: true))
)

#let lists = figure.with(
  kind: "lists",
  numbering: none,
  supplement: none,
  outlined: true,
  caption: []
)

#let toc = context {
  outline(
    title: lists(localization.at(text.lang).toc),
    indent: 1.2em,
    target: target,
  )
}

// Table of contents
#let list_of_figures = context {
  outline(
    title: lists(localization.at(text.lang).list_of_figures),
    target: figure.where(kind: image),
  )
}

#let list_of_tables = context {
  outline(
    title: lists(localization.at(text.lang).list_of_tables),
    target: figure.where(kind: table),
  )
}

// TODO
#let nomenclature = { }

// =========================================================
// The ASM template also provides a theorem function.
#let theorem(body, numbered: true) = figure(
  body,
  kind: "theorem",
  supplement: localization.at(text.lang).theorem,
  numbering: if numbered { "1" },
)

// And a function for a proof.
#let proof(body) = block(
  spacing: 11.5pt,
  {
    emph(localization.at(text.lang).proof + ".")
    [ ] + body
    h(1fr)
    box(scale(160%, origin: bottom + right, sym.square.stroked))
  },
)
