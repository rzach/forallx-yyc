# Accessibility of forall x: Calgary

## HTML version

## Tagged PDF

I'm in the process to change
[_forallx:Calgary_](https://forallx.openlogicproject.org/) so that it
can be compiled with the LaTeX code currently being developed that
outputs accessible PDFs, i.e., PDFs that comply with the [PDF/UA-2
standard](https://pdfa.org/iso-14289-2-pdfua-2/). These PDFs are
"tagged", i.e., they basically contain an HTML version of the text
that appears on the page and which can be used by assistive
technologies (AT) such as screen readers. Formulas have to be
converted to MathML when they are inserted into that tagging
structure. The [LaTeX tagging
project](https://latex3.github.io/tagging-project/) has added support
to LaTeX to produce tagged PDFs automatically. The result should be
PDF/UA-2 compliant as long as the LaTeX source, including any packages
you use, are compatible with tagging support. Incidentally, that means
that if you rely on XeLaTeX, you have your work cut out for you as I
believe that's entirely incompatible (but also deprecated and you
should switch to LuaLaTeX anyway where `fontspec` gives you OTF fonts).

The [`luamml`
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

I made a number of changes to the source in 2023 to enable LaTeXML to
produce an HTML version. (The experience is summarized at
https://richardzach.org/2023/07/converting-latex-to-html-technical-notes/
and a more high-level description is here:
https://richardzach.org/2025/03/accessible-open-textbooks-in-math-heavy-disciplines/).
These changes helped in the process of producing tagged PDF in the
sense that a lot of what was `TeX hacking' in the original code to
produce the right visual output didn't work for the HTML output and
had to be cleaned up. Yet a few more changes are needed for tagged
PDF, mainly because a lot of classes and packages are not compatible
with tagging (or at least not "aware" of tagging).

- First of all, _forallx:YYC_ relies on the `memoir` class, which is
  [incompatible with
  tagging](https://github.com/latex3/tagging-project/issues/910). I
  made some changes in `memoir.sty`: `forallxyyc-ua` loads
  [`memoir-tagging`](https://github.com/rzach/memoir-tagging) instead.
  This provides a version of `memoir` that is minimally compatible
  with tagging ("minimally" means it basically just fixes how `memoir`
  handles headings and table of contents). This could be avoided (and
  things would be easier) if we used the `book` class instead, but
  then we can't use any of `memoir`'s convenient features to set the
  page layout or style headings. In the end I think I will go that
  route, i.e., use `book` and compatible packages (`geometry` for page
  layout, `fancyhdr` for page styles, directly editing the heading
  templates for parts and chapters).
- The code in `forallxyyc.sty` and `forallxyyc-style.sty` also has to
  be adjusted.
  - The various lists are configured using the `enumitem` package,
    which is also incompatible with tagging. However, with tagging
    code loaded, the standard list environments support many of the
    same configuration options as those provided by `enumitem`, and
    LaTeX itself then [automatically
    emulates](https://ctan.org/tex-archive/macros/latex/required/latex-lab/latex-lab-enumitem.pdf)
    things like `\newlist` and `\setlist`. A few changes were
    necessary to make sure only those `enumitem` options are used that
    the tagging code recognizes. A bug in LaTeX that prevents
    `\newlist` from working correctly with `description` [has been
    fixed](https://github.com/latex3/latex2e/commit/a50f8b98945d2feb43e6aeb02381d1c780352c02)
    but the fix isn't rolled out yet. 
  - Tagging (or at least the part that produces MathML code used to
    tag math formulas) requires `lua-unicode-math` and that in turn
    requires that a compatible math font is loaded. That rules out
    `newtxmath`, which provides a math font that goes with the
    BaskervaldX text font. So the tagged version (at least when it is
    run with `lualatex` and `luamml` to produce MathML) has to load
    different fonts. 
- `fitch.sty` was slightly incompatible with tagging: a `fitchproof`
    environment used a `list` environment to provide a bit of space
    above and below a proof. This resulted in all Fitch proofs being
    tagged as tables inside a 1-item list. I changed it to use a
    `flushleft` environment in [v1.1 of
    `fitch`](https://github.com/OpenLogicProject/fitch). (If anyone
    still uses `\nd` in math mode to set Fitch proofs, that is not
    compatible with tagged PDFs. *forallx* and `fitch` changed that
    already for the conversion to HTML; see the `fitch` manual.)
- All images need descriptions. These were already provided by the
  `\bmlDescription` commands for use in the HTML, added to all
  `tikzpicture` environments. Since recently (and perhaps only with
  the development code loaded, not sure), `tikzpicture` also supports
  an `alt={Description}` option; that is now used in addition to
  `\bmlDescription`.
- LaTeX will automatically tag the title if you use `\maketitle` but
  this is a book and the title and half-title pages are more
  complicated.
  - The (illustrated) cover is an issue since in the
    tagging structure it should just be treated as an image with `alt`
    text ("Book cover"). But if you produce it in the main `.tex` file
    by overlaying text on the cover graphics, LaTeX will insist on
    tagging the title, author, edition text. (You can turn off tagging
    but then there will be untagged text on p. 0 and the PDF doesn't
    validate.) My solution is to use LaTeX to produce
    a PDF of just the cover, and insert that on p. 0 using
    `\includegraphics[alt={Book cover}]`.
  - The title page itself is provided on p. i and has to be tagged "by
    hand", basically copying what [LaTeX does in
    `\maketitle`](https://github.com/latex3/latex2e/blob/develop/required/latex-lab/latex-lab-title.dtx)
    "under the hood".
- Seemingly normal things break if you don't use the modern way
  of doing things that exist in LaTeX, e.g.,
  - `\let\emph\textbf` doesn't work
    (https://github.com/latex3/tagging-project/issues/1606). Use
    `\RenewCommandCopy` instead of `\let`, or better
    `\DeclareEmphSequence{\bfseries}`. (Need to test if LaTeXML
    understands the new ways or conversion to HTML breaks!)
  - `pdflatex` runs out of memory when tagging a document with lots of
    tables (https://github.com/latex3/tagging-project/issues/1608) and
    *forallx* has *lots* of them. So always use `lualatex` (or
    `lualatex-dev` for bleeding edge bugfixes and features).

Any changes made have the potential to break things in both the
regular PDF and in the HTML generated by LaTeXML, so this requires
regular checking of the HTML output (and eventually a thorough
re-validation of the HTML for accessibility).

### Things I'm still working on

- MathML can only be generated with `lua-unicode-math` loaded, and
  that's incompatible with lots of fonts. Once it is generated,
  however, it should be possible to compile with with the right fonts
  (and so produce the same PDF for screen reading and printing), and
  tag formulas with the previously generated MathML. So the workflow
  would be
  - compile with `lualatex` and `lua-unicode-math` loaded, but no
    special fonts, to get MathML
  - copy the generated `forallxyyc-ua-luamml-mathml.html` to
    `forallxyyc-ua-mathml.html` (this is important because the
    generated file, which would otherwise be loaded, will be
    overwritten. And without `lua-unicode-math` you'll get lots of
    incorrect characters like "2" for `\Box`, not even parentheses
    will be right.)
  - recompile without `lua-unicode-math` but with fonts loaded to get
    the right fonts in the PDF and the right MathML in the tagging
    structure.
- ~~Need to figure out how to make `memoir-tagging` start paragraphs
  after chapters without indent
  (https://github.com/latex3/tagging-project/issues/1617). The chapter
  styles are also slightly off from what they are with "real" memoir
  (different spacing, mostly).~~ (https://github.com/latex3/tagging-project/issues/1617)
- Parts are the top heading level used but chapters are tagged as `H1`
  and parts aren't made into `SECTION`s. This is apparently the
  intended way it is supposed to work
  (https://github.com/latex3/tagging-project/issues/1596).
- Italicized book titles in references (e.g., at end of Ch. 44 and
  various footnotes) lose italics in derived HTML. This works as
  intended, as they are not emphasized, and italics that aren't
  emphasis don't show up in the alternate text.
- Optional argument to `\section` breaks derived HTML, e.g., Sec 46.1.
- Math weirdness happening at the end of 47.2 and 47.3.
- `\tikzpictures` produces weird images in the derived HTML. This may
  be an issue if you use liquid mode in some PDF viewers; for screen
  readers it doesn't matter.
- a [bug in
  `latex-lab-enumitem`](https://github.com/latex3/tagging-project/issues/1595)
  prevents `ekey`s from working properly. What I'm doing now
  (redefining `\makelabel`) isn't supported by `latex-lab-enumitem`.
  (Workaround: add math to `\item[...]` instead of doing it in the label
  format.)
- ~~Another [bug](https://github.com/latex3/tagging-project/issues/1557)
  makes `\item[]` behave the same as `\item` (instead of forcing the
  label to be empty). So some displayed sentences coded with
  `compactlist` are numbered when they shouldn't be. This is fixed in
  development.~~
- Make sure the triangle pointers in itemized lists and `\therefore`
  in text arguments are not formulas/tagged as MathML. (Solution: use
  `\MathCollectFalse\ensuremath{\triangleright}\MathCollectTrue` to
  avoid conversion into MathML. Perhaps need to code
  `\texttriangleright` and `\texttherefore` using unicode (▻ and ∴) --
  or do that anyway so you don't need to test if we're going to HTML
  using LaTeXML.) See
  https://github.com/latex3/tagging-project/discussions/1621
- In the HTML, the "blanks" are underlines with invisible text so that
  screen readers read them out as "blank". In the PDF these blanks are
  generated by `\underline`s and there is currently no way to provide a
  text equivalent for these. I have proposed to option to add `alt`
  tags to them
  (https://github.com/latex3/tagging-project/issues/1502); let's see
  how this goes.
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
- Get `\define` tagged properly. LaTeX doesn't know about a `Strong`
  tag; all it can do is turn `\emph` into an `Em` tag. For now, trick
  it into also making `\define` into an `Em` tag using
  ```
  \UseTaggingSocket{inline/begin}{tag=\UseStructureName{text/emph}}
  ```
  The LaTeX team is planning to implement `Strong`:
  https://github.com/latex3/tagging-project/issues/1620
- LaTeX treats `align` environments very differently from LaTeXML. The
  latter turns every line into a formula, and the formulas are put
  into an alignment table. This makes sense. LaTeX instead treats the
  whole environment as a giant formula with lines being rows in an
  `<mtable>`. In particular, `\intertext` is turned into an `<mtext>`
  inside the formula. This makes e.g. chains of equivalences with long
  interleaved text inaccessible. There's also a bug where `\intertext`
  generates warnings (https://github.com/latex3/tagging-project/issues/1341).
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
- Figure out how and what document metadata to add; see
  https://github.com/latex3/tagging-project/discussions/1483

# General things to do now and later

- Have to make sure the result actually works! That includes:
  - Making sure the PDF passes PDF/UA-2 verification:
    - https://ngpdf.com/loadFile
    - https://dev.verapdf-rest.duallab.com/
    - https://pac.pdf-accessibility.org/en (Windows only, may not
      support PDF/UA-2 yet)
  - Universities will use commercial testing suites such as
    [Ally](https://help.anthology.com/ally-lms/?lang=en) and [Pope
    Tech](https://www.pope.tech/). UCalgary doesn't subscribe to any,
    but it would be good to make sure they don't flag the resulting
    PDFs. That may be tricky because they may not support the newest
    standards. See the list of validation erros reported at
    https://github.com/latex3/tagging-project/discussions/categories/issues-with-accessibility-checkers-and-other-at-software 
  - Even when the tagged PDF passes validation, the many different
    screen readers will vary as to how they behave in practice. So there
    will have to be testing using actual screen reader software and
    preferably actual users, not just running automated validation
    tools.
- The HTML version will remain the "more accessible" version (probably
  forever) especially because the PDF can't make derivations properly
  accessible even with tagging (although I have some more ideas for
  `fitch`).
- For slides to go with *forallx*, we can't use `beamer` to produce
  tagged PDF, since it's incompatible. Use
  [`ltx-talk`](https://ctan.org/pkg/ltx-talk) and maybe the Stage-talk
  theme (see https://beameratelier.com/ltx-talk.html) instead.