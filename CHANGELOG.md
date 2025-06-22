# Summary of changes

## Changes in Fall 2025 edition

- Terminology for _provably equivalent_ replaced by _interderivable_
- More careful discussion of relation between semantic and proof
  theoretic notions
- Added rules for subproofs to the quick reference appendix
- Many typos and minor errors fixed

## Changes in Fall 2023 edition

- Fully accessible HTML version and SCORM packages using BookML
  ([issue 23](https://github.com/rzach/forallx-yyc/issues/23)). This
  required many changes under the hood; see the [blog post on
  technical
  details](https://richardzach.org/2023/07/converting-latex-to-html-technical-notes/).
- Proofs now label premises by
  PR and assumptions by AS (helps with accessibility, and makes
  textbook match Carnap's conventions more closely).
- New chapter 13 (Limitations of TFL) based in part on section 12.5 of
  F21 edition.
- New chapter 35 (Properties of relations)
- Removed confusing sketch of soundness proof from chapter 22 ([issue
  66](https://github.com/rzach/forallx-yyc/issues/66))
- Moved section 30.4 (Satisfaction of formulas) to section 32.2
  (Expressibility) and expanded it.
- Added solutions to problems in chapters 7 and 29 (Ambiguity)
- Added explanation on quantifier restriction at end of section 25.4
  ([issue 57](https://github.com/rzach/forallx-yyc/issues/57))
- Added material to section 27.3 on vacuous quantification, revised
  definitions of substitution to substitute only free occurrences of
  variables, and added section 36.6 to explain what can go wrong if
  you're not careful with substitution ([issue
  77](https://github.com/rzach/forallx-yyc/issues/77))
- Revisions to section 4.2 to bring it in line with the terminology of
  chapter 3.
- Added brief discussion of asymmetric use of “and” in section 5.2
- Many minor revisons, fixed typos, and fixed formatting

## Changes in the Fall 2021 edition

- Add chapter 45 on chains of equivalences
- Add discussion of “only” and “except” to chapter
- Lots of spelling, grammar fixes
- Notes for instructors in Preface

## Changes in the Fall 2020 edition

- some behind-the-scenes reorganization of the files (e.g, it now
  uses a stock `fitch.sty`, `forallxyyc-style.sty` with just the
  formatting stuff separate from `forallxyyc.sty` so the latter can
  be used in beamer slides)
- renamed “expressively adequate” to “functionally complete”
- incorporated some changes from the Cambridge version
- moved chapter “Sentences of FOL” to before the “Definite
  descriptions” chapter
- added two chapters on ambiguity (7, 28)
- added “only” to section 23.1
- split the chapter on normal forms and functional completeness into
  two
- corrected some typos

## Changes in the Fall 2019 edition

-  New cover design by Mark Lyall.
-  Rewritten/revised chapters 1–3, avoiding modality when defining
   validity and instead talk about “cases” (the way JC Beall and Shay
   Logan do in their book, _Logic: The Basics_).
-  Changed the syntax of FOL: formulas are now F(x, y) instead of Fxy.
   This can be customized in forallxyyc-local.sty, though.
-  Changed some terminology: “logical consistency” is now
   “satisfiability” (and cognates), “logical truths” are now
   “validities”.
-  Sentence letters now allowed in FOL formulas.
-  Reiteration is now a basic rule, so that proofs can be in normal
   form.
-  Chapter 28 now defines satisfaction of a formula by an object, so
   that truth conditions for quantifiers can be stated more cleanly.
-  New chapters 16, 33 on strategies for constructing proofs.
-  Added three chapters on modal logic (natural deduction proof system
   and Kripke semantics). They are based on _A Modal Logic Primer_ by
   Rob Trueman (University of York), which he was generous enough to
   share. I’ve changed his proof system to use Fitch’s modal rules. It
   covers the basics of K, T, S4, and S5.
-  Added a chapter on soundness for TFL proofs, from Tim Button’s
   _Metatheory_.
-  Corrected various errors and added various clarifications.