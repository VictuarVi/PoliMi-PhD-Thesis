/// LaTeX sizes to match original templates (https://tex.stackexchange.com/questions/24599/what-point-pt-font-size-are-large-etc)
/// -> dict
#let _sizes = (
  "10pt": (
    tiny: 5pt,
    scriptsize: 7pt,
    footnotesize: 8pt,
    small: 9pt,
    normalsize: 10pt,
    large: 12pt,
    Large: 14.4pt,
    LARGE: 17.28pt,
    huge: 20.74pt,
    Huge: 24.88pt,
  ),
  "11pt": (
    tiny: 6pt,
    scriptsize: 8pt,
    footnotesize: 9pt,
    small: 10pt,
    normalsize: 10.95pt,
    large: 12pt,
    Large: 14.4pt,
    LARGE: 17.28pt,
    huge: 20.74pt,
    Huge: 24.88pt,
  ),
  "12pt": (
    tiny: 6pt,
    scriptsize: 8pt,
    footnotesize: 10pt,
    small: 10.95pt,
    normalsize: 12pt,
    large: 14.4pt,
    Large: 17.28pt,
    LARGE: 20.74pt,
    huge: 24.88pt,
    Huge: 24.88pt,
  ),
)

/// The current state (title page, front-,main-,backmatter...)
/// -> state
#let _document-state = state("init", "TITLE_PAGE")

/// The current type of document.
/// -> state
#let _document-type = state("init", "phd")

/// Localization dictionary. It could be deprecated since thesises are written exclusively in English.
/// -> dict
#let _localization = yaml("locale.yaml")

/// Signature PoliMi colour (#box(baseline: 0.1em, rect(height: 0.7em, width: 0.7em, fill: rgb("#5f859f")))), used in headings and labels.
/// -> color
#let bluepoli = rgb("#5f859f")

/// Check if a page is empty.
/// -> bool
#let _is-page-empty() = {
  // https://forum.typst.app/t/how-to-use-set-page-without-adding-an-unwanted-pagebreak/3129/2
  let current-page = here().page()
  query(<chapter-end>)
    .zip(query(<chapter-start>))
    .any(((start, end)) => {
      (start.location().page() < current-page and current-page < end.location().page())
    })
}

/// Adds an empty page between an odd page and the next. Used to check when to remove the header and place a raggiera in the bottom left corner.
/// -> content
#let _empty-page() = {
  [#metadata(none) <chapter-end>]
  pagebreak(weak: true, to: "odd")
  [#metadata(none) <chapter-start>]
}

/// It displays a reference using section name (instead of numbering). From Hallon 0.1.3
/// -> content
#let _nameref(label) = {
  show ref: it => {
    if it.element == none {
      it
    } else if it.element.func() != heading {
      it
    } else {
      let l = it.target // label
      let h = it.element // heading
      link(l, h.body)
    }
  }
  ref(label)
}


/// Inserts a raggiera, given a specified width.
/// -> content
#let _raggiera-image(
  /// Width of the raggiera.
  /// -> length
  width,
) = (
  image(
    "img/raggiera.svg",
    width: width,
  )
)

/// Draw a banner.
/// -> content
#let banner(
  /// Body of the banner.
  /// -> content
  body,
) = rect(
  width: 100%,
  fill: bluepoli.lighten(40%), // #9AAFC2
  inset: (rest: 1em, x: 1.7em),
  text(
    fill: white,
    body,
  ),
)

// Numbering functions

/// Alternative numbering: ```typc"1.1." + h-space```.
/// -> content
#let tab-numbering(
  /// Horizontal space.
  /// -> length
  h-space: 0.7em,
  /// Numbers.
  /// -> arguments
  ..n,
) = n.pos().map(str).join(".") + "." + h(h-space)

/// Chapter numbering.
/// -> content
#let chapter-numbering(
  /// Numbers.
  /// -> arguments
  ..n,
) = text(weight: "bold", str(n.pos().first())) + "|" + h(2mm)

/// Numbering used in the theses header.
/// -> content
#let header-number(
  /// Numbers.
  /// -> arguments
  ..n,
) = return str(n.pos().first()) + "| "

#let shared-formatting(title, author, language, body, text-size: 11pt, keywords: "") = {
  set document(
    title: title,
    author: author,
    keywords: keywords,
  )

  set text(
    lang: language,
    size: text-size,
    font: "New Computer Modern",
    hyphenate: true,
  )
  show math.equation: set text(font: "New Computer Modern Math")

  set par(
    justify: true,
    linebreaks: "optimized",
    spacing: 0.7em,
    first-line-indent: 0pt,
  )

  set figure(gap: 1.5em)
  show figure: set block(breakable: true)
  show: _style-figures.with(colored-caption: true, heading-levels: 1)

  body
}

// presentation

#import "@preview/touying:0.6.1": *

/// The background panes used in some scenarios.
/// -> dict
#let _pane = (
  left: 15.86cm,
  right: 51.86cm,
)

/// (1..20) -> (01,02,03,...,20)
/// -> numbering
#let _custom-numbering = (..args) => {
  let numbers = args.pos()
  let output = numbering(
    "1",
    ..numbers,
  )
  if (str(numbers.first()).len() == 1) {
    output = "0" + output
  }
  return output
}

/// Empty block.
/// -> content
#let _spacer(width, height) = block(
  width: width,
  height: height,
)

/// Internal stroke.
/// -> stroke
#let _stroke-no-border(color) = (x, y) => (
  top: if (y > 0) { (paint: color, thickness: 0.1pt) },
  left: if (x > 0) { (paint: color, thickness: 0.1pt) },
)

/// Custom made header.
/// -> content
#let _poli-header(
  /// The text arguments for the title.
  /// -> dict
  text-args: (size: 15pt, weight: "regular", fill: rgb("#5e5e5e")),
  self,
) = context {
  set text(..text-args)
  let svg-bytes = read("img/9-cerchi.svg")
  svg-bytes = svg-bytes.replace(
    "#aaaaaa",
    text-args.fill.to-hex(),
  )
  let toc-label = query(<_polimi-digital-presentation-toc>)
  show: pad.with(left: 2cm, right: 1.25cm)
  grid(
    columns: (_pane.left, 1fr),
    {
      _custom-numbering(counter(heading.where(level: 1)).at(here()).at(0))
      ". "
      utils.display-current-heading(level: 1, numbered: false)
    },
    {
      self.info.title
      " | "
      self.info.date
      h(1fr)
      if toc-label.len() != 0 {
        link(
          (page: toc-label.first().location().page(), x: 0pt, y: 0pt),
          box(
            image(bytes(svg-bytes), height: 1em),
            baseline: 10%,
          ),
        )
      }
      h(1cm)
      context utils.slide-counter.display()
    },
  )
}

/// Apply a fill colour to the panes.
/// -> content
#let _poli-bg-split() = {
  set rect(stroke: none, height: 100%)
  stack(
    dir: ltr,
    rect(width: _pane.left, fill: rgb("#fdfdfd")),
    rect(width: _pane.right, fill: rgb("#f3f3f3")),
  )
}

// DIVIDER

/// New section body, that is title, lettering and chapter number.
/// -> content
#let _divider-body(title, lettering, number, text-fill) = {
  if title != none {
    pad(
      top: 7.54cm,
      left: 15.93cm,
      text(
        size: 54pt,
        weight: "bold",
        fill: text-fill,
        title,
      ),
    )
  }
  if lettering != none {
    place(
      bottom,
      pad(
        bottom: 0.32cm, // forse da sistemare
        left: 15.93cm,
        text(
          fill: text-fill,
          lettering,
        ),
      ),
    )
  }
  if number != none {
    place(
      right + bottom,
      pad(
        right: 2.71cm,
        bottom: 2cm,
        text(
          size: 200pt,
          weight: "light",
          fill: text-fill,
          number,
        ),
      ),
    )
  }
}

/// Style the new section background.
/// -> content
#let _divider-bg(fill, stroke) = {
  return (
    fill: fill,
    background: {
      place(top + left, grid(
        columns: (auto, 1fr),
        stroke: _stroke-no-border(stroke),
        inset: (right: 0.1cm),
        align: horizon,
        [], _spacer(100%, 20%),
        circle(radius: 72mm / 2, stroke: stroke), [],
        _spacer(auto, 1fr),
      ))
    },
  )
}
