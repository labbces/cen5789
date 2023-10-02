
# rerun if any changes are made to the # ## ### #### in the README.md
head -n 11 ../unix.md > toc.md
START=2
tail +10 ../unix.md | ./gh-md-toc - | perl -p -e 's/\(#/\(unix.md\/#/' >> toc.md
tail +6 ../bioinfo.md  | ./gh-md-toc - | perl -p -e 's/\(#/\(bioinfo.md\/#/' >> toc.md
#tail +$START ../workshops/README.md | ./gh-md-toc - | perl -p -e 's/\(#/\(workshops.md\/#/' >> toc.md


## copy the contents of toc.md to README.md to create a TOC with more depth
