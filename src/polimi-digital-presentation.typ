#import "@preview/touying:0.6.1": *
#import "utils.typ": *
#import "colors.typ": *

/// Basic slide.
/// -> content
#let poli-slide(
  /// Touying overrides for this slide.
  /// -> dictionary
  config: (:),
  /// Whether to repeat this slide.
  /// -> auto | bool
  repeat: auto,
  setting: body => body,
  composer: auto,
  ..args,
  body,
) = touying-slide-wrapper(self => {
  let self = utils.merge-dicts(
    self,
    config-page(header: _poli-header),
    config-common(
      slide-preamble: block(
        inset: (top: 4.6cm),
        text(
          size: 42pt,
          weight: "light",
          fill: self.colors.primary,
          utils.display-current-heading(level: 2),
        ),
      ),
    ),
  )
  touying-slide(
    self: self,
    config: config,
    repeat: repeat,
    setting: setting,
    composer: composer,
    ..args,
    body,
  )
})

// TITLE SLIDE

/// The title slide. The style can be specified via the corresponding argument.
/// -> content
#let title-slide(
  /// Style of the title slide.
  /// -> "default" | "white" | "logos" | "background"
  style: "default",
  /// Subtitle content.
  /// -> content
  subtitle: none,
  /// Supplied background for the "background" style; otherwise ignored.
  /// -> image
  background: none,
  /// Supplied Logos for the "logos" style; otherwise ignored.
  /// -> array
  logos: (),
  /// Touying overrides for this slide.
  /// -> dictionary
  config: (:),
) = touying-slide-wrapper(self => {
  let title-style = (
    "default": (
      text: (fill: white),
      stroke: white,
      logo: image("img/logo/white.svg"),
      fill: gradient.linear(rgb("#042f57"), rgb("#c3c6c9"), angle: -90deg),
    ),
    "white": (
      text: (fill: self.colors.primary),
      stroke: self.colors.primary,
      logo: image("img/logo/blue.svg"),
    ),
    "logos": (
      text: (fill: white),
      stroke: white,
      logo: image("img/logo/blue.svg"),
      fill: gradient.linear(rgb("#042f57"), rgb("#c3c6c9"), angle: 90deg),
      height: 15.47cm - 6cm,
      height-subtitle: -23cm,
    ),
    "background": (
      text: (fill: self.colors.primary),
      stroke: self.colors.primary,
      logo: image("img/logo/white.svg"),
      circle-above: image("img/title/background/above.svg"),
      circle-below: image("img/title/background/below.svg"),
      height: 17.8cm,
    ),
  )
  if (style == "background") {
    assert(
      background != none,
      message: "You need to specify a background if you want to use background title style.",
    )
  }
  if (style == "logos") {
    assert(
      logos.len() != 0,
      message: "You need to specify logos if you want to use logos title style.",
    )
  }
  self = utils.merge-dicts(
    self,
    config,
    config-page(
      // foreground: title-style.at(style).at("foreground", default: none),
      fill: title-style.at(style).at("fill", default: none),
      background: move(
        dy: if style == "logos" { -6cm } else { 0cm },
        {
          if style == "background" {
            place(
              top + left,
              background,
            )
          }
          grid(
            columns: (42cm, 22.28cm, 1fr),
            align: (top + left, center, center),
            stroke: _stroke-no-border(title-style.at(style).stroke),
            block(
              inset: (left: 3cm, top: 3cm),
              if style != "logos" { title-style.at(style).logo },
            ),
            title-style.at(style).at("circle-above", default: image("img/title/above.svg")),
            [],

            [], title-style.at(style).at("circle-below", default: image("img/title/below.svg")),
          )
        },
      ),
      footer-descent: if style == "logos" { -4.1cm } else { 30% },
      footer: if style == "logos" {
        show: components.cell.with(
          fill: white,
          height: 6cm,
          inset: (x: 2cm),
        )
        set align(horizon)
        grid(
          columns: (13cm,) + (auto,) * logos.len(),
          column-gutter: 1cm,
          align: left + horizon,
          {
            set image(height: 4cm)
            title-style.at(style).logo
          },
          ..logos
        )
      },
    ),
  )
  let body = {
    show: pad.with(top: title-style.at(style).at("height", default: 15.47cm))
    let info = self.info
    block(
      width: 42cm,
      {
        text(
          size: 120pt,
          weight: "extrabold",
          ..title-style.at(style).at("text", default: none),
          info.title,
        )
        v(title-style.at(style).at("height-subtitle", default: 1fr))
        text(
          size: 18pt,
          weight: "light", // o extralight
          ..title-style.at(style).at("text", default: none),
          {
            let arr = (info.author,)
            let tmp = info.at("theme", default: none)
            if tmp != none {
              arr.push(tmp)
            }
            arr.join(" / ") + " | " + info.date
          },
        )
        v(1cm)
      },
    )
  }
  touying-slide(self: self, config: config, body)
})

/// Generate the outline based on headings.
/// -> content
#let make-outline(config: (:), ..args) = touying-slide-wrapper(self => {
  let self = utils.merge-dicts(
    self,
    config,
    config-page(
      fill: rgb("#f3f3f3"),
    ),
    config-common(
      subslide-preamble: block(
        inset: (top: 40pt, bottom: 45pt),
        text(
          size: 42pt,
          fill: self.colors.primary,
          "Table of Contents",
        ),
      ),
    ),
  )
  let body = context {
    let h1-h2-headings = query(heading).filter(e => e.level <= 2)
    let h1s = h1-h2-headings.filter(e => e.level == 1).len()

    let h1s-final = ()
    let h2s-final = ()

    for i in range(0, h1-h2-headings.len()) {
      if h1-h2-headings.at(i).level == 1 {
        let tmp = ()
        let j = i + 1
        while j < h1-h2-headings.len() and h1-h2-headings.at(j).level != 1 {
          tmp.push(h1-h2-headings.at(j))
          j = j + 1
        }
        let h1-linked = link(h1-h2-headings.at(i).location(), h1-h2-headings.at(i).body)
        h1s-final.push(h1-linked)
        let h2-linked = tmp.map(e => link(e.location(), e.body))
        h2s-final.push(h2-linked)
      }
    }

    let _max-columns = 6

    let arr = (
      range(1, h1s + 1).map(e => rotate(
        270deg,
        reflow: true,
        text(
          size: 100pt,
          weight: 300,
          str(_custom-numbering(e)),
        ),
      )),
      h1s-final.map(e => text(
        size: 23pt,
        weight: "bold",
        underline(e),
      )),
      if h2s-final != none {
        h2s-final.map(
          sections => sections.map(e => underline(text(fill: gray, e))).join("\n"),
        )
      },
    ).map(e => e.chunks(_max-columns))

    arr = arr.at(0).zip(arr.at(1), arr.at(2))

    arr = (
      arr
        .map(arr => arr.map(e => {
          if e.len() < _max-columns {
            return e + ("",) * (_max-columns - e.len())
          } else {
            return e
          }
        }))
        .map(e => (
          e.at(0),
          e.at(1),
          e.at(2).map(e => if type(e) == array { e.join("\n") } else { e }),
        ))
    )


    [#metadata(none) <_polimi-digital-presentation-toc>]
    grid(
      columns: (1fr,) * _max-columns,
      gutter: 1cm,
      align: (_, y) => if y <= 1 { left + bottom } else { left },
      ..arr.flatten()
    )
  }
  touying-slide(self: self, config: config, body)
})

// TEXT SLIDES

// Slide di solo testo enfatizzato, cioè una frase incredibile
#let emphasis-text-slide(
  /// Touying overrides for this slide.
  /// -> dictionary
  config: (:),
  body,
) = touying-slide-wrapper(self => {
  let self = utils.merge-dicts(
    self,
    config-page(
      header: _poli-header,
    ),
  )
  touying-slide(self: self, config: config, body)
})

// Slide di SOLO testo -- cioè la slide normale
// #let text-slide(config: (:), body) = touying-slide-wrapper(self => {
//   let self = utils.merge-dicts(
//     self,
//     config-page(
//       header: _poli-header,
//     ),
//   )
//   touying-slide(self: self, config: config, body)
// })

// SPLIT SLIDES

/// Slide exactly split in 2 or 4. Requires content for each split.
/// -> content
#let exact-split-slide(
  /// Content of each split. Usually a title with a small description.
  /// -> arr
  splits: (),
  /// Touying overrides for this slide.
  /// -> dictionary
  config: (:),
) = touying-slide-wrapper(self => {
  let splits-num = splits.len()
  self = utils.merge-dicts(
    self,
    config,
    config-common(
      subslide-preamble: block(
        inset: (top: 3cm),
        text(
          size: 42pt,
          weight: "light",
          fill: self.colors.primary,
          utils.display-current-heading(level: 2),
        ),
      ),
    ),
    config-page(
      header: _poli-header(self),
      background: {
        set line(length: 100%, angle: 90deg, stroke: self.colors.cerchi-stroke)
        set circle(stroke: self.colors.cerchi-stroke)
        set stack(dir: ltr)
        if splits-num == 2 {
          stack(
            circle(radius: 16cm),
            line(),
            circle(radius: 16cm),
          )
        } else if splits-num == 4 {
          let bottom-circle = align(bottom, pad(bottom: 1.91cm, circle(radius: 8cm)))
          stack(
            bottom-circle,
            line(),
            bottom-circle,
            line(),
            bottom-circle,
            line(),
            bottom-circle,
          )
        } else {
          panic("The splits must be either 2 or 4.")
        }
      },
    ),
  )
  let body = {
    grid(
      columns: (1fr,) * splits-num,
      align: left + horizon,
      inset: {
        if splits-num == 2 { 5cm }
        if splits-num == 3 { 3cm }
        if splits-num == 4 { 0.7cm }
      },
      ..splits
    )
  }
  touying-slide(self: self, config: config, body)
})

/// Split a slide in two panes -- similar to header spacing.
/// -> content
#let split-slide(
  /// Left split content.
  /// -> content
  left: [],
  /// Right split content.
  /// -> content
  right: [],
  /// Touying overrides for this slide.
  /// -> dictionary
  config: (:),
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config,
    config-common(
      subslide-preamble: block(
        inset: (top: 4.6cm, bottom: 1.8cm),
        text(
          size: 42pt,
          weight: "light",
          fill: self.colors.primary,
          utils.display-current-heading(level: 2),
        ),
      ),
    ),
    config-page(
      header: _poli-header,
      background: _poli-bg-split(),
    ),
  )
  let body = grid(
    columns: (_pane.left - 2cm, _pane.right - 1.25cm),
    inset: (x, _) => if x == 0 { (right: 2cm) } else { (left: 2cm) },
    left, right,
  )
  touying-slide(self: self, config: config, body)
})

// GRAPHIC SLIDES

/// Slide with coloured background. Used for plots.
/// -> content
#let plot-slide(
  /// Touying overrides for this slide.
  /// -> dictionary
  config: (:),
  body,
) = touying-slide-wrapper(self => {
  let self = utils.merge-dicts(
    self,
    config,
    config-page(
      header: _poli-header(self, text-args: (size: 15pt, weight: "regular", fill: white)),
      fill: self.colors.primary,
    ),
  )
  let body = {
    components.cell(height: 2.5cm)
    set text(fill: white)
    body
  }
  touying-slide(self: self, config: config, body)
})

/// Slide with image on the left, right or as whole background. Deprecated. Use
/// ```typc background-slide()```.
/// -> content
#let image-slide(
  /// Image for the slide.
  /// -> image
  image: none,
  /// Style of the image, that is where it will be placed and sized.
  /// -> "background" | "left"
  style: "background",
  /// Touying overrides for this slide.
  /// -> dictionary
  config: (:),
  body,
) = touying-slide-wrapper(self => {
  panic("Deprecated!")
  let self = utils.merge-dicts(
    self,
    config,
    config-page(
      header: _poli-header(
        self,
        text-args: (
          size: 15pt,
          weight: "regular",
          fill: if style == "background" { white } else { rgb("#5e5e5e") },
        ),
      ),
      background: if style == "background" {
        set std.image(height: 100%, width: 100%)
        image
      } else if style == "left" {
        _poli-bg-split()
      },
    ),
  )
  let body = {
    body
  }
  touying-slide(self: self, config: config, body)
})

/// Slide with image as whole background.
/// -> content
#let background-slide(
  /// Image for the slide.
  /// -> image
  image: none,
  /// Touying overrides for this slide.
  /// -> dictionary
  config: (:),
  body,
) = touying-slide-wrapper(self => {
  let self = utils.merge-dicts(
    self,
    config,
    config-page(
      header: _poli-header(
        self,
        text-args: (
          size: 15pt,
          weight: "regular",
          fill: white,
        ),
      ),
      background: {
        set std.image(height: 100%, width: 100%)
        image
      },
    ),
  )
  let body = {
    body
  }
  touying-slide(self: self, config: config, body)
})


// FOCUS SLIDE

/// Acknowledgements slide. Usually with "Thanks for watching!" or similar phrases.
/// -> content
#let focus-slide(
  /// Bottom lettering.
  /// -> content
  lettering: none,
  config: (:),
  body,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config,
    config-page(
      // OPINIONATED CHOICE non ha senso che in questa slide ci sia un header
      // header: _poli-header(self, text-args: (size: 15pt, weight: "regular", fill: white)),
      .._divider-bg(self.colors.primary, self.colors.divider.dark),
    ),
  )
  let body = _divider-body(body, lettering, none, white)
  touying-slide(self: self, config: config, body)
})

// SECTION DIVIDERS

/// The so-called "Divisorio", a new section. Invoked with a level 1 heading.
/// -> content
#let _new-section-slide(config: (:), ..args) = touying-slide-wrapper(self => {
  let config-divisorio = if self.store.divider-style == "dark" {
    (self.colors.primary, self.colors.divider.dark)
  } else {
    (rgb("#e2e6eb"), rgb("#7a8aa0"))
  }
  let self = utils.merge-dicts(
    self,
    config-page(
      .._divider-bg(..config-divisorio),
    ),
  )
  let body = _divider-body(
    utils.display-current-heading(
      level: 1,
      numbered: false,
    ),
    none,
    context _custom-numbering(counter(heading.where(level: 1)).at(here()).at(0)),
    if self.store.divider-style == "dark" {
      white
    } else {
      self.colors.primary
    },
  )
  touying-slide(config: config, self: self, body)
})

/// The other so-called "Divisorio", but for lvl.2 heading and in a light background. Unused.
/// -> content
#let _new-subsection-slide(config: (:), ..args) = touying-slide-wrapper(self => {
  let self = utils.merge-dicts(
    self,
    config,
    config-page(
      .._divider-bg(rgb("#e2e6eb"), rgb("#7a8aa0")),
    ),
  )
  let body = _divider-body(
    text(
      fill: self.colors.primary,
      utils.display-current-heading(
        level: 2,
        numbered: false,
      ),
    ),
    none,
    text(
      fill: self.colors.primary,
      context {
        _custom-numbering(counter(heading.where(level: 1)).at(here()).at(0))
        "."
        str(counter(heading.where(level: 2)).at(here()).at(1))
      },
    ),
  )
  touying-slide(config: config, self: self, ..args, body)
})

// MAIN FUNCTION

/// Main presentation function.
/// -> content
#let polimi-digital-presentation(
  /// The style of the divider.
  /// -> "dark" | "light"
  divider-style: "dark",
  ..args,
  body,
) = {
  set text(size: 24pt, font: "Manrope")
  show heading.where(level: 1): set heading(numbering: "1")
  // show heading.where(level: 2): set heading(numbering: "1")

  show table.cell: it => {
    if it.y == 0 {
      text(fill: white, it)
    } else if it.x == 0 {
      text(fill: _poli-palette.main, it)
    } else {
      it
    }
  }
  set table(
    align: center + horizon,
    inset: (x: 3cm, y: 1.5cm),
    stroke: (x, y) => (
      top: if y > 0 { if x == 0 { white + 1pt } else { gray + 1pt } },
      bottom: if y > 0 { if x == 0 { white + 1pt } else { gray + 1pt } },
      left: if x > 0 { gray },
    ),
    fill: (x, y) => {
      if y > 0 and x == 0 {
        rgb("#c0cbd5")
      } else if x > 0 and y == 0 {
        _poli-palette.main
      }
    },
  )

  show: touying-slides.with(
    config-page(
      width: 677mm,
      height: 381mm,
      margin: (
        top: 3cm, // SISTEMARE
        x: 2cm,
        bottom: 2.5cm,
      ),
    ),
    config-common(
      slide-fn: poli-slide,
      new-section-slide-fn: _new-section-slide,
      // new-subsection-slide-fn: new-subsection-slide,
    ),
    config-colors(
      primary: _poli-palette.main,
      cerchi-stroke: rgb("#c0cbd5"),
      divider: (
        dark: rgb("#7F94A9"),
        light: rgb("#E1E6EB"),
      ),
    ),
    config-store(
      divider-style: divider-style,
    ),
    ..args,
  )

  body
}
