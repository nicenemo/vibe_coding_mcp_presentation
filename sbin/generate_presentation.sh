#!/bin/bash
(cat presentation.yml; for f in $(ls -v [0-9]*.md); do echo; echo '---'; echo; cat "$f"; done) > presentation.tmp
mv presentation.tmp presentation.md
pandoc -t revealjs -s presentation.md -o presentation.html --include-in-header=header.html -V theme=black -V css=custom.css
