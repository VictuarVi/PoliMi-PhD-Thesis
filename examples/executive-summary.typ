#import "@preview/elegant-polimi-thesis:0.1.2": *

#show: polimi-executive-summary

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
  "Thesis_bibliography.bib",
  full: true,
)
