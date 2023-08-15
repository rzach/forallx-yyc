# forall x: Calgary

[![Book Cover](https://forallx.openlogicproject.org/forallxyyc.png)](https://forallx.openlogicproject.org/forallxyyc.pdf)

## Description

_forall x: Calgary_ is a full-featured textbook on formal logic. It
covers key notions of logic such as consequence and validity of
arguments, the syntax of truth-functional propositional logic TFL and
truth-table semantics, the syntax of first-order (predicate) logic FOL
with identity (first-order interpretations), symbolizing English in
TFL and FOL, and Fitch-style natural deduction proof systems for both
TFL and FOL. It also deals with some advanced topics such as modal
logic, soundness, and functional completeness. Exercises with
solutions are available. It is provided in PDF (for screen reading,
printing, and a special version for dyslexics), HTML, and in LaTeX
source code.

Instructors wishing to adopt it should consider the open-source
[Carnap](https://carnap.io/) system, which supports the notation and
proof systems of _forall x: Calgary_. Check out the [sample
exercises](https://carnap.io/shared/rzach@ucalgary.ca/forall%20x:%20Calgary.md)
for the book on carnap.io. (There is also an outdated and unsupported
proof editor/checker for the proof system used available at
[proofs.openlogicproject.org](https://proofs.openlogicproject.org/).)

The book has been translated into German ([forall _x_:
Dortmund](https://github.com/sbwimmer/forallx-do)) and Portuguese
([Para Tod*x*s:
Natal](https://github.com/Grupo-de-Estudos-em-Logica-da-UFRN/Para-Todxs-Natal)).

## Read online

The book is available in HTML [to read
online](https://forallx.openlogicproject.org/html/).

The HTML conversion is experimental. If you find issues in it,
especially issues that affect screen readers, please report it by
[filing an issue](https://github.com/rzach/forallx-yyc/issues) or send
an email to [Richard Zach](mailto:rzach@ucalgary.ca). Note that
solutions are not yet included in the HTML version.

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

The a [SCORM](https://adlnet.gov/past-projects/scorm/) ZIP package of
HTML bundled with plain and accessible versions of the PDF is
available here:

  - [SCORM.forallxyyc.zip](https://forallx.openlogicproject.org/SCORM.forallxyyc.zip)

You can use this file to easily provide the entire text inside your
LMS (Canvas, Moodle, D2L/Brightspace).

**Note that these files change whenever the source files change.** So
if you use the text in a course, it is best to download the PDFs or
the SCORM package and make them available to students directly rather
than to link here, to avoid mismatches between versions.

Major changes between editions are listed in the [changelog](https://github.com/rzach/forallx-yyc/blob/master/CHANGELOG.md).

PDFs of the **Fall 2021** edition are archived here:

  - [`forallxyyc-f21.pdf`](https://forallx.openlogicproject.org/forallxyyc-f21.pdf)
  - [`forallxyyc-accessible-f21.pdf`](https://forallx.openlogicproject.org/forallxyyc-accessible-f21.pdf)
  - [`forallxyyc-print-f21.pdf`](https://forallx.openlogicproject.org/forallxyyc-print-f21.pdf)
  - [`forallxyyc-letter-f21.pdf`](https://forallx.openlogicproject.org/forallxyyc-letter-f21.pdf)
  - [`forallxyyc-solutions-f21.pdf`](https://forallx.openlogicproject.org/forallxyyc-solutions-f21.pdf)

PDFs of the **Fall 2020** edition are archived here:

  - [`forallxyyc-f20.pdf`](https://forallx.openlogicproject.org/forallxyyc-f20.pdf)
  - [`forallxyyc-accessible-f20.pdf`](https://forallx.openlogicproject.org/forallxyyc-accessible-f20.pdf)
  - [`forallxyyc-print-f20.pdf`](https://forallx.openlogicproject.org/forallxyyc-print-f20.pdf)
  - [`forallxyyc-letter-f20.pdf`](https://forallx.openlogicproject.org/forallxyyc-letter-f20.pdf)
  - [`forallxyyc-solutions-f20.pdf`](https://forallx.openlogicproject.org/forallxyyc-solutions-f20.pdf)

## Buy a Printed Copy

If you'd like to purchase a nice paperback copy of the Fall 2021 edition, you can do so on
Amazon ([US](https://www.amazon.com/dp/B097XGMP17) |
[CA](https://www.amazon.ca/dp/B097XGMP17) |
[UK](https://www.amazon.co.uk/dp/B097XGMP17) |
[DE](https://www.amazon.de/dp/B097XGMP17) | 
[AU](https://www.amazon.com.au/dp/B097XGMP17)), or use search in your
local Amazon store. Be sure to get the latest version that's available
in print (Fall 2021). The version on Amazon usually is not as current
as the PDF. (Specifically, to avoid a jump in prices due to Amazon's
new pricing scheme, the F21 version on Amazon has not been updated to
include the (minor) [corrections made after January 2022](https://github.com/rzach/forallx-yyc/compare/F21-kdp...rzach:forallx-yyc:master).

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

## Credits and License

_forall x: Calgary_ is based on [_forall x:
Cambridge_](https://www.homepages.ucl.ac.uk/~uctytbu/OERs.html), by
[Tim Button](https://www.homepages.ucl.ac.uk/~uctytbu/index.html) used
under a [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)
license, which is based in turn on [_forall
x_](https://www.fecundity.com/logic/), by
[P.~D. Magnus](https://www.fecundity.com/job/) used under a [CC BY
4.0](https://creativecommons.org/licenses/by/3.0/) license, and was
remixed, revised, & expanded by [Aaron
Thomas-Bolduc](https://phil.ucalgary.ca/profiles/aaron-thomas-bolduc)
& [Richard Zach](https://richardzach.org/).  It includes additional
material from _forall x_ by P.~D. Magnus and
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

