# Accessibility of forall x: Calgary

## HTML version

I made a number of changes to the source in 2023 to enable LaTeXML to
produce an HTML version. (The experience is summarized at
https://richardzach.org/2023/07/converting-latex-to-html-technical-notes/
and a more high-level description is here:
https://richardzach.org/2025/03/accessible-open-textbooks-in-math-heavy-disciplines/).

## Tagged PDF

I'm in the process to change [_forall
x:Calgary_](https://forallx.openlogicproject.org/) so that it can be
compiled with the LaTeX code currently being developed that outputs
accessible PDFs, i.e., PDFs that comply with the [PDF/UA-2
standard](https://pdfa.org/iso-14289-2-pdfua-2/). These PDFs are
"tagged", i.e., they basically contain an HTML version of the text
that appears on the page and which can be used by assistive
technologies (AT) such as screen readers. Formulas have to be
converted to MathML when they are inserted into that "tagging
structure". The [LaTeX tagging
project](https://latex3.github.io/tagging-project/) has added support
to LaTeX to produce tagged PDFs automatically. The result should be
PDF/UA-2 compliant as long as the LaTeX source, including any packages
you use, are compatible with tagging support. Incidentally, that means
that if you rely on XeLaTeX, you have your work cut out for you as I
believe that's entirely incompatible (but also deprecated and you
should switch to LuaLaTeX anyway where `fontspec` gives you OTF
fonts).

In PDF/UA-2, formulas have to be tagged by MathML. The [`luamml`
](https://ctan.org/tex-archive/macros/luatex/latex/luamml/luamml.pdf)
package is loaded if MathML tagging is requested and the document is
processed with `lualatex`. It will convert formulas to MathML
automatically. The [quick start
guide](https://latex3.github.io/tagging-project/documentation/usage-instructions)
explains what (minimally) has to be done.

I made a new source file `forallxyyc-ua.tex` (plus
`forallxyyc-style-ua.sty`) for this, since whether the tagging code is
loaded is determined by the presence (and options to) a
`\DocumentMetadata` command at the top, before the class is loaded. So
it's tricky to use the same code with tagging (for development) and
without (for safely producing updated PDFs).

To make sure the tagging code (which is continuously being updated)
works as intended, it should be compiled with the latest bleeding-edge
version of LuaLaTeX:
```
lualatex-dev forallxyyc-ua
```
In fact, success depends essentially on having an up-to-date version
of LaTeX and all packages available. The tagging code is included at
least in TeXLive 2026, but I found that I needed features or bug fixes
that need a more current version from CTAN. So best results (if you
don't want to/can't wait for TeXLive 2027) are had with TeXLive
[installed directly](https://tug.org/texlive/quickinstall.html) not
via a package frozen to some annual snapshot. Im not sure how
up-to-date MikTeX and MacTex are or can be (i.e., if you can make them
update things on the fly from CTAN or if they also only provide
irregular snapshots). I suspect on Overleaf your experience will be
worst: you could manually copy various packages from CTAN into your
project to override the core LaTeX packages and classes but if your
code relies on a feature or bugfix of `lualatex` itself, you're SOL.


The changes I made in 2023 to provide an HTML version helped in the
process of producing tagged PDF in the sense that a lot of what was
`TeX hacking' in the original code to produce the right visual output
didn't work for the HTML output and had to be cleaned up. Yet a few
more changes are needed for tagged PDF, mainly because a lot of
classes and packages are not compatible with tagging (or at least not
"aware" of tagging).

- First of all, _forallx:YYC_ relies on the `memoir` class, which is
  [incompatible with
  tagging](https://github.com/latex3/tagging-project/issues/910). I
  made some changes in `memoir.sty`: 
  [`memoir-tagging`](https://github.com/rzach/memoir-tagging).
  This provides a version of `memoir` that is minimally compatible
  with tagging ("minimally" means it basically just fixes how `memoir`
  handles headings and table of contents). This could be avoided (and
  things would be easier) if we used the `book` class instead, but
  then we can't use any of `memoir`'s convenient features to set the
  page layout or style headings. 
- In the end I did go that route. For PDF/UA I use `book` and
  compatible packages: `geometry` for page layout, `fancyhdr` for page
  styles, `tocloft` for the ToC, and directly editing the heading
  templates for parts and chapters. The changes required are
  documented in the source and also described in the [`memoir-tagging`
  README](https://github.com/rzach/memoir-tagging/blob/main/README.md).

The code in `forallxyyc.sty` and `forallxyyc-style.sty` also has to
be adjusted.
- The various lists are configured using the `enumitem` package, which
  I started using because it's the best way to configure lists with
  LaTeXML. But: it is also incompatible with tagging. However, with
  tagging code loaded, LaTeX's *standard* list environments support
  many of the same configuration options as those provided by
  `enumitem`, and LaTeX itself then [automatically
  emulates](https://ctan.org/tex-archive/macros/latex/required/latex-lab/latex-lab-enumitem.pdf)
  things like `\newlist` and `\setlist`. A few changes were necessary
  to make sure only those `enumitem` options are used that the tagging
  code recognizes. I had to wait until a few bugs
  ([1518](https://github.com/latex3/tagging-project/issues/1518),
  [1557](https://github.com/latex3/tagging-project/issues/1557),
  [1595](https://github.com/latex3/tagging-project/issues/1595)) were
  fixed. They may not yet be fixed in older versions, e.g., in TeXLive
  2026. But at least with the latest LaTeX development code this is
  working.
- `fitch.sty` was slightly incompatible with tagging: a `fitchproof`
  environment used a `list` environment to provide a bit of space
  above and below a proof. This resulted in all Fitch proofs being
  tagged as tables inside a 1-item list. I changed it to use a
  `flushleft` environment in [v1.1 of
  `fitch`](https://github.com/OpenLogicProject/fitch). (If anyone
  still uses `\nd` in math mode to set Fitch proofs, that is not
  compatible with tagged PDFs. *forallx* and `fitch` changed that
  already for the conversion to HTML; see the `fitch` manual.) This
  made `fitch` compatible with tagging. It's not yet properly
  accessible though; working on that (see [issue
  1485](https://github.com/latex3/tagging-project/issues/1485)).
- All images need descriptions. These were already provided by the
  `\bmlDescription` commands for use in the HTML via LaTeXML, added to
  all `tikzpicture` environments. The `tikzpicture` environment, like
  the `\includegraphics` command before, now also supports an
  `alt={Description}` option; that is now used in addition to
  `\bmlDescription`.
- LaTeX will automatically tag the title if you use `\maketitle` but
  this is a book and the title and half-title pages are more
  complicated.
  - The (illustrated) cover is an issue since in the tagging structure
    it should just be treated as an image with `alt` text ("Book
    cover"). But if you produce it in the main `.tex` file by
    overlaying text on the cover graphics, LaTeX will insist on
    tagging the title, author, edition text. (You can turn off tagging
    but then there will be untagged text on p. 0 and the PDF doesn't
    validate.) My solution is to use LaTeX to produce a PDF of just
    the cover, and insert that on p. 0 using
    `\includegraphics[alt={Book cover}]`.
  - The title page itself is provided on p. i and has to be tagged "by
    hand", basically copying what [LaTeX does in
    `\maketitle`](https://github.com/latex3/latex2e/blob/develop/required/latex-lab/latex-lab-title.dtx).

I ran into a few other issues along the way, e.g.,

- `\let\emph\textbf` doesn't work
  ([issue 1606](https://github.com/latex3/tagging-project/issues/1606)). Use
  `\RenewCommandCopy` instead of `\let`, or better
  `\DeclareEmphSequence{\bfseries}`. (Need to test if LaTeXML
  understands the new ways or conversion to HTML breaks!)
- `pdflatex` runs out of memory when tagging a document with lots of
  tables ([issue
  1608](https://github.com/latex3/tagging-project/issues/1608)) and
  *forall x* has *lots* of them. Another reason to use `lualatex` or
  `lualatex-dev` from now on.

Any changes made have the potential to break things in both the
regular PDF and in the HTML generated by LaTeXML, so this requires
regular checking of the HTML output (and eventually a thorough
re-validation of the HTML for accessibility).

### Things I'm still working on

- MathML can only be generated with `unicode-math` or
  `lua-unicode-math` loaded, and that's incompatible with some fonts
  or font setups. In particular you can't use it if you use `pdflatex`
  and legacy T1 fonts that don't have proper Unicode mappings. Once
  the MathML is generated, however, it is possible to compile with
  different fonts, including legacy fonts (and so produce the same PDF
  for screen reading and printing without switching to new fonts), and
  tag formulas with the previously generated MathML. So the workflow
  would be
  - compile with `lua-unicode-math` loaded, but no special fonts, to
    get good MathML.
  - copy the generated `forallxyyc-ua-luamml-mathml.html` to
    `forallxyyc-ua-mathml.html` (this is important because the
    generated file, which would otherwise be loaded, will be
    overwritten.)
  - recompile without `lua-unicode-math` but with fonts loaded to get
    the right fonts in the PDF and the right MathML in the tagging
    structure. (The main file can do that automatically by testing if
    `forallxyyc-ua-mathml.html` exists.)
- Although I made some progress with the above approach and the
  original font setup, in the end it turned out to be too hard/relied
  on the goodwill and help of too many font maintainers to get the
  final PDF to have all symbols correctly map to unicode characters.
  So I decided to take the plunge and switch to OpenType fonts. It
  turned out it's possible and actually not too hard with
  [`fontspec`]{https://ctan.org/pkg/fontspec}, at least for the fonts
  I wanted.
  - Loading BaskervaldX and Helvetica for the text is not a big deal.
    Instead of loading the `baskervaldx` and `helvetica` packages, you
    load the corresponding OTF fonts directly in LuaLaTeX using `fontspec`:
    ```
    \usepackage{fontspec}
    \setmainfont{Baskervaldx}
    \setsansfont{NimbusSans}
    ```
  - Math fonts were trickier to figure out. You don't load them with
    packages like `amssymb` or `newtxmath`, but using
    [`unicode-math`](https://ctan.org/pkg/unicode-math). The newer
    [`lua-unicode-math`](https://ctan.org/pkg/lua-unicode-math)
    package can also load some math fonts, but it's a little less
    stable and has fewer features. There are a lot fewer OTF math
    fonts, but there are some that are comprehensive, i.e., basically
    contain every symbol that has a unicode equivalent (and possibly
    more). You pick one that has all the symbols you need and that
    goes with your text font. There is one immense [list of
    symbols](https://mirrors.ctan.org/macros/unicodetex/latex/unicode-math/unimath-symbols.pdf)
    available in those. If you don't select another math font, you
    just get standard Computer Modern, which is too light for most
    text fonts. I picked STIX 2:
    ```
    \usepackage{unicode-math}
    \setmathfont{STIXTwoMath-Regular.otf}
    ```
  - To get the latin math letters to match the text font you say
    ```
    \setmathfont[range=it/{num,latin,Latin}]{Baskervaldx-Ita.otf}
    \setmathfont[range=up/{num,latin,Latin}]{Baskervaldx-Reg.otf}
    \setmathfont[range=bf/{num,latin,Latin}]{Baskervaldx-Bold.otf}
    ```
    This means: take `\mathit` Latin uppercase and lowercase letters
    from BaskervaldX Italic Regular. (The "Latin" is necessary or else
    it'll also try to take Greek letters and Baskervald doesn't have
    those.) The `range` option is not supported (yet) by
    `lua-unicode-math`.
  - This approach works fine in that it produces matching fonts for
    letters in math mode. It does not work fine for MathML: `luamml`
    relies on the unicode characters in the math font. If an actual
    math font is used, this works: "𝑥" for \mathit{x}, "𝒙" for
    \mathbf{x}, etc. (A list of all of these is at
    https://en.wikipedia.org/wiki/Mathematical_Alphanumeric_Symbols.)
    But if you replace the math fonts with the text fonts, these will
    all just be ASCII "x" and in the MathML you'll get `<mi
    mathvariant="normal">x</mi>` instead of `<mi>𝑥</mi>` or
    `<mi>𝒙</mi>`. My solution is to use the trick above: Don't
    overwrite the math font and generate a MathML associated file (AF)
    in a first pass that has the right math unicode characters, then
    use the generated file in a second pass where you do overwrite the
    math fonts. See the [discussion on
    Github](https://github.com/latex3/tagging-project/discussions/1639).
  - You'll probably have to either change commands from whatever
    you're used to from `amssymb` etc. to the `unicode-math` commands
    (see the big table). `unicode-math` does its work at the beginning
    of the document, not immediately where it appears in the preamble,
    and `\let` doesn't seem to work. So e.g.:
    ```
    \AtBeginDocument{%
      \RenewCommandCopy{\Box}{\mdlgwhtsquare}
      \RenewCommandCopy{\Diamond}{\mdlgwhtdiamond}
      \renewcommand{\texttherefore}{\ensuremath{\therefore}}}
    ```
    to get `amssymb`'s `\Box` and `\Diamond` to pick the right
    characters and to define `\texttherefore` at the proper time.
- `part`s are the top heading level used but chapters are tagged as `H1`
  and parts aren't made into `SECTION`s. This is apparently the
  intended way it is supposed to work
  (https://github.com/latex3/tagging-project/issues/1596).
- Italicized book titles in references (e.g., at end of Ch. 44 and
  various footnotes) lose italics in derived HTML. This works as
  intended, as they are not emphasized, and italics that aren't
  emphasis don't show up in the alternate text.
- Two optional arguments to `\section` (as provided by `memoir`)
  breaks derived HTML, e.g., Sec 46.1. The new LaTeX `\section`
  implementation provides a key-value interface and you can set the
  `toc` and `running` titles separately; see [latex-lab-sec-template
  docs](https://ctan.org/tex-archive/macros/latex/required/latex-lab/latex-lab-sec-template.pdf).
- Math weirdness happening at the end of 47.2 and 47.3.
- `\tikzpictures` produces weird images in the derived HTML you get
  using ngPDF. This may be an issue if you use liquid mode in some PDF
  viewers; for screen readers it doesn't matter. It may just be an
  issue with ngPDF.
- Make sure the triangle pointers in itemized lists and `\therefore`
  in text arguments are not formulas/tagged as MathML. (Solution: use
  `\MathCollectFalse\ensuremath{\triangleright}\MathCollectTrue` to
  avoid conversion into MathML. Perhaps need to code
  `\texttriangleright` and `\texttherefore` using unicode (▻ and ∴) --
  or do that anyway so you don't need to test if we're going to HTML
  using LaTeXML.) See the [discussion on
  Github](https://github.com/latex3/tagging-project/discussions/1621).
- The LaTeX source (and `fitch`) code many numbers as formulas, mainly
  to ensure that line line numbers always use a consistent font (e.g.,
  "`line~$5$ in the above proof`"). This makes them all be converted
  to MathML, which is not good: it's overkill and inefficient, and it
  makes screen readers pause or announce formulas at every number.
  `fitch` already avoids that in proofs. For the body text it requires
  changing all such numbers-as-formulas from `$5$` to e.g.,
  `\number{5}` and defining `\number` as
  ```
  \MathCollectFalse\ensuremath{#1}\MathCollectTrue
  ```
- In the HTML version, "iff" is spelled with an invisible zero-length
  word joiner as "if f". That tricks screen readers into pronouncing
  it as "if-eff". Must investigate if this works in tagged PDF/LaTeX
  too.
- In HTML, "PR" and "AS" are coded using `<abbr>` tags. There is an
  `/E` value to provide the expansion of an abbreviation in a
  `<SPAN>` tag in tagged PDF. LaTeX can generate
  those probably using `E` or `raw`, perhaps:
  ```
  \UseTaggingSocket{inline/begin}
      {tag=\UseStructureName{span},E=Premise}PR\UseTaggingSocket{inline/end}
  ```
- In the HTML, the "blanks" are underlines with invisible text so that
  screen readers read them out as "blank". In the PDF these blanks are
  generated by `\underline`s and there is currently no way to provide a
  text equivalent for these. Planning to try the same trick as above.
- Get `\define` tagged properly. LaTeX doesn't know about a `Strong`
  tag; all it can do is turn `\emph` into an `Em` tag. For now, trick
  it into also making `\define` into an `Em` tag using
  ```
  \UseTaggingSocket{inline/begin}{tag=\UseStructureName{text/emph}}
  ```
  The LaTeX team is planning to implement `Strong`, see [issue 1620](
  https://github.com/latex3/tagging-project/issues/1620).
- LaTeX treats `align` environments very differently from LaTeXML. The
  latter turns every line into a formula, and the formulas are put
  into an alignment table. This makes sense. LaTeX instead treats the
  whole environment as a giant formula with lines being rows in an
  `<mtable>`. In particular, `\intertext` is turned into an `<mtext>`
  inside the formula. This makes e.g. chains of equivalences with long
  interleaved text inaccessible. `\intertext` also gives warnings;
  waiting for [issue
  1341](https://github.com/latex3/tagging-project/issues/1341) to be
  fixed. Long term the best solution is probably to avoid `\intertext`
  and/or `align*`.
- [`luamml`](https://ctan.org/tex-archive/macros/luatex/latex/luamml/luamml.pdf)
  allows you to specify the MathML for a LaTeX construct using
  `\luamml_annotate` (not something LaTeXML can do) and this is used
  in
  [`latex-lab-mathintent`](https://ctan.org/tex-archive/macros/latex/required/latex-lab/latex-lab-mathintent.pdf)
  to provide the `intent` attribute for MathML. This may be used to,
  e.g., override what screen readers pronounce various things as
  (e.g., we could provide `intent="entails"` for the MathML of
  `\models`) and also prevent screen readers from imagining invisible
  times between $R$ and $(a)$ in $R(a)$. See https://w3c.github.io/mathml-docs/
- Figure out how and what document metadata to add; see the
  [discussion on
  Github](https://github.com/latex3/tagging-project/discussions/1483).
- WCAG doesn't like it if you skip heading levels, which is a problem
  since `paragraph` is not consistently (or ever) used as heading
  level 4. Set the heading level in an optional argument, e.g,
  `\paragraph[level=2]` if it follows a `\chapter`. (This also has to
  be fixed in HTML with a class applied to the `<h4>` tag used for
  `paragraph` by LaTeXML.)
- URLs that are also links will throw WCAG errors and need a
  descriptive label, i.e., an `Alt` or `aria-label` tag on the link.
  See [issue
  1640](https://github.com/latex3/tagging-project/issues/1640) for the
  issue in PDF. Should also be fixed for HTML with `aria-label`.
- Floats (`table`, `figure`) are placed by LaTeX's layout algorithm
  and not necessarily where they are in the source document (e.g.,
  they may be at the top of the next or even previous page).
  In the PDF tagging structure this is not the case. LaTeX by default
  collects all floats at the very end of a document, relying on the
  content author to link to a float (and ideally back). This makes
  consulting tables and figures using screen readers difficult. A
  better way would be to place the tagged structure containing the
  float (e.g., a table) where it appears in the reading order. This
  can be accomplished by issuing
  ```
  \tagpdfsetup{float/here}
  ```
  at the beginning of the document. (If it is desirable to make the
  visual placement and logical reading order match exactly, you can
  use the `float` package that provides an `[H]` placement option and
  does not move the float at all.)
  The [`latex-lab-float`
  documentation](https://ctan.org/tex-archive/macros/latex/required/latex-lab/latex-lab-float.pdf)
  describes other placement options.

# General things to do now and later

- Have to make sure the result actually works! That includes:
  - Making sure the PDF passes PDF/UA-2 and/or WCAG validation:
    - https://ngpdf.com/loadFile lets you load and inspect the file
      and look at the HTML that would be generated (approximating what
      a screen reader reads out).
    - https://dev.verapdf-rest.duallab.com/ checks for conformance
      with PDF/UA and PDF/A specifications (i.e., if the tagging is
      done properly).
    - https://pdf4wcag.com/ is built on top of VeraPDF and adds
      heuristic checks for WCAG accessibility rules.
    - https://octopdf.com/ also checks for accessibility but has an
      upload limit of 2MB (too low for forallx).
    - https://pdfix.io/validate-pdf-ua/ same limit, but there is a
      free desktop (Windows, iOS, Linux) PDF checker
      https://pdfix.net/download/#desktop 
    - https://pac.pdf-accessibility.org/en (Windows only, may not
      support PDF/UA-2 yet)
    - https://check.axes4.com/en (The scanner behind PAC, no need for
      a download, but crapped out for me with "unknown error")
    - https://thelatexlab.com/pdf-ua-checker/ (PDF/UA-2 checker, not
      sure how reliable it is. It does not seem to recognize MathML
      AF.)
    - https://allyant.com/free-pdf-accessibility-checker-validator/ is
      a free PDF/UA and WCAG validator plugin for Adobe Acrobat
  - Universities will use commercial testing suites such as
    [Ally](https://help.anthology.com/ally-lms/?lang=en) and [Pope
    Tech](https://www.pope.tech/). UCalgary doesn't subscribe to any,
    but it would be good to make sure they don't flag the resulting
    PDFs. That may be tricky because they may not support the newest
    standards. See the list of validation erros reported at the [LaTeX
    project discussion site](https://github.com/latex3/tagging-project/discussions/categories/issues-with-accessibility-checkers-and-other-at-software).
  - Even when the tagged PDF passes validation, the many different
    screen readers will vary as to how they behave in practice. So
    there will have to be testing using actual screen reader software
    and preferably actual users, not just running automated validation
    tools.
- The HTML version will remain the "more accessible" version (probably
  forever) especially because the PDF can't easily make derivations
  properly accessible even with tagging (although I have some more
  ideas for `fitch`).
- For slides to go with *forallx*, we can't use `beamer` to produce
  tagged PDF, since it's incompatible. Use
  [`ltx-talk`](https://ctan.org/pkg/ltx-talk) and maybe the Stage-talk
  theme (see https://beameratelier.com/ltx-talk.html) instead.