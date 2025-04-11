#import "@local/polimi-phd-thesis:1.0.0": *

#show: polimi_thesis.with(language: "en")

#show: frontmatter.with()

#include "sections/abstract.typ"

#toc
#list_of_figures
#list_of_tables
#let nomenclature_ = (
  "Polimi": "Politecnico di Milano",
  "CdL": "Corso di Laurea",
  "CCS": "Consigli di Corsi di Studio",
  "CFU": "Crediti Formativi Universitari"
)
#nomenclature(
  nomenclature_,
  indented: false
)

#show: mainmatter.with()

#heading("Introduction", level: 1)

#include "sections/chapter_1.typ"
#include "sections/chapter_2.typ"

#show: backmatter.with()

#bibliography(
  "../template/Thesis_bibliography.bib",
  full: true,
)

#show: appendix.with()

#include "sections/appendix_1.typ"
#include "sections/appendix_2.typ"

#show: acknowledgements.with()

#include "sections/acknowledgements.typ"
