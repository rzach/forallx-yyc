### CONFIGURATION
# Remove the initial '#' and change the value to customise the build process
# See CONFIGURATION in bookml/bookml.mk for all the options
#
# Options can also be customized on the command line, for instance
#   make SPLITAT= singlepage.zip
# will compile singlepage.tex into a single page
#
# For example: remove '#' below to split your document by chapter

# split at chapters
SPLITAT = chapter
# includestyles, otherwise fitch.sty is not processed and we get no
# proofs
# --nomathtex to leave out the tex code in ALT tags on math elements
# --nocomments to remove comments from HTML
LATEXMLEXTRAFLAGS     = --includestyles --nocomments
LATEXMLPOSTEXTRAFLAGS = --pmml --nomathtex --css=forallxyyc.css --css=fitchml.css

# Only convert the HTML driver not all the other TEX files
SOURCES = forallxyyc-html.tex
### END CONFIGURATION

include bookml/bookml.mk

# You may also override SPLITAT and other options for a single file, as follows:
#singlepage.zip: SPLITAT=
