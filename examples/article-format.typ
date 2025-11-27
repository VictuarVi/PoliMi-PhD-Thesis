#import "@preview/elegant-polimi-thesis:0.1.2": *

#show: polimi-article-format-thesis.with(
  abstract: [
    Here goes the Abstract in English of your thesis (in article format)
    followed by a list of keywords. The Abstract is a concise summary of the content
    of the thesis (single page of text) and a guide to the most important contributions
    included in your thesis. The Abstract is the very last thing you write. It should
    be a self-contained text and should be clear to someone who hasn’t (yet) read the
    whole manuscript. The Abstract should contain the answers to the main research
    questions that have been addressed in your thesis. It needs to summarize the
    motivations and the adopted approach as well as the findings of your work and
    their relevance and impact. The Abstract is the part appearing in the record
    of your thesis inside POLITesi, the Digital Archive of PhD and Master Theses
    (Laurea Magistrale) of Politecnico di Milano. The Abstract will be followed by
    a list of four to six keywords. Keywords are a tool to help indexers and search
    engines to find relevant documents. To be relevant and effective, keywords must
    be chosen carefully. They should represent the content of your work and be specific
    to your field or sub-field. Keywords may be a single word or two to four words
  ],
)

= Introduction

This document is intended to be both an example of the Polimi Typst template for Master Theses in article format, as well as a short introduction to its use. It is not intended to be a general introduction to Typst itself, and the reader is assumed to be familiar with the basics of creating and compiling Typst documents.

//(see \cite{oetiker1995not, kottwitz2015latex}).

The cover page of the thesis in article format must contain all the relevant information: title of the thesis, name of the Study Programme, name(s) of the author(s), student ID number, name of the supervisor, name(s) of the co-supervisor(s) (if any), academic year.

Be sure to select a title that is meaningful. It should contain important keywords to be identified by indexer. Keep the title as concise as possible and comprehensible even to people who are not experts in your field. The title has to be chosen at the end of your work so that it accurately captures the main subject of the manuscript.

It is convenient to break the article format of your thesis (in article format) into sections and subsections.  If necessary, subsubsections, paragraphs and subparagraphs can be used.

A new section is created by the command
```typ
= Title of the section
```

The numbering can be turned off by using the complete function:
```typ
#heading(numbering: none, "Title of the section")
```

A new subsection is created by the command:
```typ
== Title of the subsection
```
and similarly the numbering can be turned off as earlier, but changing the level:
```typ
#heading(numbering: none, level: 2 "Title of the section")
```

It is recommended to give a label to each section by using the command
```typ
= Title of the section<section-name>
```
where the argument is just a text string that you'll use to reference that part
as follows: ```typ @section-name```.

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

= Equations

= Figures, Tables and Algorithms

== Figures

== Tables

== Algorithms

= Some further useful recommendations

// theorems and such

How to insert itemized lists:
- first item;
- second item.

How to insert numbered lists:
1. first item;
2. second item.

= Use of copyrighted material

Each student is responsible for obtaining copyright permissions, if necessary, to include published material in the thesis. This applies typically to third-party material published by someone else.

= Plagiarism

You have to be sure to respect the rules on Copyright and avoid an involuntary plagiarism. It is allowed to take other persons' ideas only if the author and his original work are clearly mentioned. As stated in the Code of Ethics and Conduct, Politecnico di Milano #emph("promotes the integrity of research, condemns manipulation and the infringement of intellectual property"), and gives opportunity to all those who carry out research activities to have an adequate training on ethical conduct and integrity while doing research. To be sure to respect the copyright rules, read the guides on Copyright legislation and citation styles available at:

#align(center, link("https://www.biblio.polimi.it/en/tools/courses-and-tutorials
"))

You can also attend the courses which are periodically organized on 'Bibliographic citations and bibliography management'.

= Conclusions

A final section containing the main conclusions of your research/study have to be inserted here.

= Bibliography and citations

Your thesis must contain a suitable Bibliography which lists all the sources consulted on developing the work. The list of references is placed at the end of the manuscript after the chapter containing the conclusions. It is suggested to use the BibTeX package and save the bibliographic references in the file `Thesis_bibliography.bib`.

#bibliography(
  "Thesis_bibliography.bib",
  full: true,
)

#show: appendix

= Appendix A

If you need to include an appendix to support the research in your thesis, you can place it at the end of the manuscript. An appendix contains supplementary material (figures, tables, data, codes, mathematical proofs, surveys, ...) which supplement the main results contained in the previous sections.

= Appendix B

It may be necessary to include another appendix to better organize the presentation of supplementary material.

#heading(numbering: none, "Abstract in lingua italiana")

Qui va l'Abstract in lingua italiana della tesi seguito dalla lista di parole chiave.

#banner[*Parole chiave*: qui, le parole chiave, della tesi, in italiano]

#show: acknowledgements

= Acknowledgements

Here you might want to acknowledge someone.
