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

/// Draw the keywords banner. Used only in `article-format` thesis.
/// -> content
#let keywords-banner(
  /// Body of the banner.
  /// -> content
  body,
) = rect(
  width: 100%,
  fill: bluepoli.lighten(40%),
  inset: (rest: 1em, x: 1.7em),
  text(
    fill: white,
    weight: "bold",
    body,
  ),
)
