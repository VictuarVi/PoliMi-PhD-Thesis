#import "@preview/elegant-polimi-thesis:0.2.0": *

#show: polimi-thesis.with(
  title: "Thesis Title",
  author: "Name Surname",
  advisor: "Advisor",
  coadvisor: "Coadvisor",
  tutor: "Tutor",
  academic-year: "2025-2026",
  cycle: "XXV",
  chair: none,
  frontispiece: sys.inputs.at("frontispiece"),
)

#show: theorems-init
#show: frontmatter

= Abstract

#lorem(100)

= Sommario

#lorem(100)

#toc
#list-of-figures
#list-of-tables

#let nomenclature_ = (
  "Polimi": "Politecnico di Milano",
  "CdL": "Corso di Laurea",
  "CCS": "Consigli di Corsi di Studio",
  "CFU": "Crediti Formativi Universitari",
)
#nomenclature(
  nomenclature_,
  indented: false,
)

#show: mainmatter

#heading("Introduction", numbering: none)

#lorem(100)

= First chapter

#lorem(100)

#show: backmatter

#show: appendix

= First appendix

#lorem(100)

#show: acknowledgements

= Acknowledgements

#lorem(100)
