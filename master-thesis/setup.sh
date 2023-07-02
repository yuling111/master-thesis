# For debian/ubuntu distributions
sudo apt install texlive-xetex
sudo apt install biber
sudo cpan Data::Lock
cp thesis-example.tex thesis.tex
cp thesis-example.bib thesis.bib
sed s/-example//g compile-opts-example.tex > compile-opts.tex