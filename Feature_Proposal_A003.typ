#show heading: it => {
  if it.level == 1 {
    set text(17pt, navy)
    align(center)[#it]
  } else if it.level == 2 {
    set text(14pt, navy)
    align(center)[#it]
  }
}

#show link: it => {
  set text(blue)
  underline(it)
} 

#set par(justify: true)

#show raw: it => {
  if it.block {
    it
  } else {
    highlight(fill: rgb("#4444"), it)
  }
}

= Feature Proposal for _*Typst*_

== Group A-003

\
#box(height: 22pt,
 columns(2, gutter: 11pt)[
   #set par(justify: true)
   #align(center)[
   Tomás Filipe Rocha e Cruz \
   ist1103425
   
   José António Ribeiro da Silva Lopes\
   ist1103938
   ]
 ]
)

#linebreak()

#par(first-line-indent: 1em)[
We are going to implement one of the feature requests present in the issue tracker of the project. 
More precisely, this one (https://github.com/typst/typst/issues/3963).
]

#par(first-line-indent: 1em)[
When a paragraph starts at the bottom of a page, it would cause it to overflow, 
meaning all of its content would be moved to a new page. 

The idea for this feature is to add the ability to specify the number of lines that must be present on a page, so that instead of the whole paragraph shifting to the next page, only a portion of it would. 
Citing the description of the previously mentioned issue: "have the flexibility to set two different thresholds for the part of the paragraph that goes respectively before and after the page break. 
For instance, `(before: 2, after: 1)`) would mean that there must be at least 2 lines on the first page, so if e.g. the paragraph is 3-lines long, it's OK to have a single line on the second page." 
]

#par(first-line-indent: 1em)[
A few tests would need to be created in order to verify the correctness of this new feature.
]

\

Predicted LoC changes: 100 lines

Predicted unit tests: 150 lines

Predicted implementation effort: 10 hours

Predicted test & debugging effort: 6 hours
