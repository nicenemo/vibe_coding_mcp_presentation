#!/bin/bash
(cat presentation.yml; for f in $(ls -v sheets/[0-9]*.md); do echo; echo '---'; echo; cat "$f"; done) > presentation.tmp
sed -i 's|\./\.\./images|images|g' presentation.tmp
mv presentation.tmp presentation.md
pandoc -t revealjs -s presentation.md -o index.html --include-before-body=header.html --include-after-body=footer.html -c custom.css -V theme=black --variable=revealjs-url:./reveal.js-4.6.1
