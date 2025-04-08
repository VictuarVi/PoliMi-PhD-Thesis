#import "@local/polimi-phd-thesis:1.0.0": *

#show: polimi_thesis.with()

#show: frontmatter.with()

#include "sections/abstract.typ"

#toc
#list_of_figures
#list_of_tables
#nomenclature // glossary package

#show: mainmatter.with()

#include "sections/chapter_1.typ"
#include "sections/chapter_2.typ"
#include "sections/chapter_3.typ"
#include "sections/chapter_4.typ"

#show: backmatter.with()

#bibliography(
  "../template/Thesis_bibliography.bib",
  full: true,
)

#show: appendix.with()

#include "sections/appendix_1.typ"
#include "sections/appendix_2.typ"
#include "sections/appendix_3.typ"
#include "sections/appendix_4.typ"

#show: acknowledgements.with()

#include "sections/acknowledgements.typ"
