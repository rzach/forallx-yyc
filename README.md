# forall x: Calgary

![Book Cover](https://forallx.openlogicproject.org/forallxyyc.png)

## Description

_forall x: Calgary_ is a full-featured textbook on formal logic. It
covers key notions of logic such as consequence and validity of
arguments, the syntax of truth-functional propositional logic TFL and
truth-table semantics, the syntax of first-order (predicate) logic FOL
with identity (first-order interpretations), translating (formalizing)
English in TFL and FOL, and Fitch-style natural deduction proof
systems for both TFL and FOL. It also deals with some advanced topics
such as modal logic, soundness, and functional completeness. Exercises
with solutions are available. It is provided in PDF (for screen
reading, printing, and a special version for dyslexics) and in LaTeX
source code.

A proof editor/checker for the proof system used is available at
[proofs.openlogicproject.org](https://proofs.openlogicproject.org/).
However, instructors wishing to adopt it should consider the
open-source [Carnap](https://carnap.io/) system, which supports the
notation and proof systems of *forall x: Calgary*. Check out the
[sample
exercises](https://carnap.io/shared/rzach@ucalgary.ca/forall%20x:%20Calgary.md)
for the book on carnap.io.

There are translations into German ([forall _x_:
Dortmund](https://github.com/sbwimmer/forallx-do)) and Portuguese
([Para Tod_x_s:
Natal](https://github.com/Grupo-de-Estudos-em-Logica-da-UFRN/Para-Todxs-Natal)).

[Download](#download) links below.

## Credits and License

_forall x: Calgary_ is based on [_forall x:
Cambridge_](https://www.homepages.ucl.ac.uk/~uctytbu/OERs.html), by
[Tim Button](https://www.homepages.ucl.ac.uk/~uctytbu/index.html) used
under a [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)
license, which is based in turn on [_forall
x_](https://www.fecundity.com/logic/), by
[P.D. Magnus](https://www.fecundity.com/job/) used under a [CC BY
4.0](https://creativecommons.org/licenses/by/3.0/) license, and was
remixed, revised, & expanded by [Aaron
Thomas-Bolduc](https://phil.ucalgary.ca/profiles/aaron-thomas-bolduc)
& [Richard Zach](https://richardzach.org/).  It includes additional
material from _forall x_ by P.D. Magnus and
[_Metatheory_](https://www.homepages.ucl.ac.uk/~uctytbu/OERs.html) by
Tim Button, both used under a [CC BY
4.0](https://creativecommons.org/licenses/by/4.0/) license, from
[_forall x: Lorain County
Remix_](https://github.com/rob-helpy-chalk/openintroduction), by
[Cathal Woods](https://sites.google.com/site/cathalwoods/) and J.
Robert Loftis, used with permission, and [_A Modal Logic
Primer_](http://www.rtrueman.com/uploads/7/0/3/2/70324387/modal_logic_primer.pdf)
by [Robert Trueman](http://www.rtrueman.com/), used with permission.

[![Creative Commons License](https://i.creativecommons.org/l/by/4.0/88x31.png)](https://creativecommons.org/licenses/by/4.0/)

This work is licensed under a [Creative Commons Attribution 4.0
International License](https://creativecommons.org/licenses/by/4.0/).

The LaTeX source code for this work is available on GitHub at
[github.com/rzach/forallx-yyc](https://github.com/rzach/forallx-yyc).

## Download

You can download PDFs of the **most current version under development** here:

  - [`forallxyyc.pdf`](https://forallx.openlogicproject.org/forallxyyc.pdf)
    (in color, for screen reading)
  - [`forallxyyc-accessible.pdf`](https://forallx.openlogicproject.org/forallxyyc-accessible.pdf)
    (an accessible version for dyslexics)
  - [`forallxyyc-print.pdf`](https://forallx.openlogicproject.org/forallxyyc-print.pdf)
    (b/w, for printing on Quarto stock)
  - [`forallxyyc-letter.pdf`](https://forallx.openlogicproject.org/forallxyyc-letter.pdf)
    (b/w, for printing on regular letter-size paper)
  - [`forallxyyc-solutions.pdf`](https://forallx.openlogicproject.org/forallxyyc-solutions.pdf)
    (solutions booklet)

**Note that these files change whenever the source files change.** So
if you use the text in a course, better to download the PDFs and make
them available to students directly, rather than to link here, to avoid
mismatches between versions.

The latest "stable" version (also available in hardcopy; see below) is **Fall 2020**. You can download PDFs of that here:

  - [`forallxyyc-f20.pdf`](https://forallx.openlogicproject.org/forallxyyc-f20.pdf)
  - [`forallxyyc-accessible-f20.pdf`](https://forallx.openlogicproject.org/forallxyyc-accessible-f20.pdf)
  - [`forallxyyc-print-f20.pdf`](https://forallx.openlogicproject.org/forallxyyc-print-f20.pdf)
  - [`forallxyyc-letter-f20.pdf`](https://forallx.openlogicproject.org/forallxyyc-letter-f20.pdf)
  - [`forallxyyc-solutions-f20.pdf`](https://forallx.openlogicproject.org/forallxyyc-solutions-f20.pdf)

## Buy a Printed Copy

If you'd like to purchase a nice paperback copy, you can do so on
Amazon ([US](https://www.amazon.com/dp/B08F6CG587) |
[CA](https://www.amazon.ca/dp/B08F6CG587) |
[UK](https://www.amazon.co.uk/dp/B08F6CG587) |
[DE](https://www.amazon.de/dp/B08F6CG587)), or use search in your
local Amazon store. Be sure to get the latest version that's available
in print (Fall 2020). The version on Amazon usually is not as current
as the PDF.

(The process for getting the book printed is described
[here](https://openlogicproject.org/2015/11/22/getting-your-book-to-print/)
and
[here](https://openlogicproject.org/2017/05/19/forall-x-yyc-is-now-on-amazon-and-how-it-got-there/).)

## Make PDFs Yourself

Clone the [GitHub repository](https://github.com/rzach/forallx-yyc) locally or download the ZIP file and run [LaTeX](https://www.latex-project.org/) on one of

  - `forallxyyc.tex` (in color, for screen reading)
  - `forallxyyc-accessible.tex` (accessible version)
  - `forallxyyc-print.tex` (b/w, for printing on Quarto stock)
  - `forallxyyc-letter.tex` (b/w, for printing on regular letter-size paper)

You'll have to run `makeglossaries` to produce the glossary as well.

To make changes to the definitions in the preamble and `forallyyc.sty`
file, put them in a file named `forallxyyc-local.sty`. For instance,
to get the connectives to be ∼, &, ⊃, ≡ instead of ¬, ∧, →, ↔, and
atomic formulas _Lab_ instead of _L(a,b)_, copy
`forallxyyc-local-sample.sty` to that file.
