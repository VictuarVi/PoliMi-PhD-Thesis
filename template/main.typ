#import "@local/polimi-phd-thesis:1.0.0": *

#show: polimi_thesis.with()

#show: frontmatter.with()

= Abstract

#lorem(100)

= Sommario

#lorem(100)

#toc
#list_of_figures
#list_of_tables
#nomenclature // glossary package

#show: mainmatter.with()

= First chapter

#lorem(100)

#show: backmatter.with()

#bibliography(
  "Thesis_bibliography.bib",
  full: true,
)

#show: appendix.with()

= First appendix

#lorem(100)

#show: acknowledgements.with()

= Acknowledgements

#lorem(100)
