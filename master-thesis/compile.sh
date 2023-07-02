TEX_FILE=${1:-thesis.tex} 
BIB_FILE=${2:-thesis.bib}
COMPILE_OPT=${3:-compile-opts.tex}
TEX_NAME="${TEX_FILE%.*}"
BIB_NAME="${BIB_FILE%.*}"

[ ! "$TEX_NAME" = "$BIB_NAME" ] && echo "[ERROR] The file names of .tex and .bib does not match." && exit

if [ ! -f "$TEX_FILE" ]; then
    echo "[WARNING] $TEX_FILE does not exist."
    while true; do
        read -p "Do you wish to use the example template as default? [Y/N]" yn
        case $yn in
            [Yy]* ) cp thesis-example.tex $TEX_FILE; break;;
            [Nn]* ) echo "Creating empty file instead. Please edit it and then compile!"; touch $TEX_FILE; exit;;
            * ) echo "Invalid input. Please answer yes or no.";;
        esac
    done
fi

[ ! -f "$BIB_FILE" ] && echo "[WARNING] $BIB_FILE does not exist. Creating empty..." && touch $BIB_FILE

if [ ! -f "$COMPILE_OPT" ]; then
    echo "[WARNING] $COMPILE_OPT does not exist."
    while true; do
        read -p "Do you wish to use the example template as default? [Y/N]" yn
        case $yn in
            [Yy]* ) sed s/thesis-example/$TEX_NAME/g compile-opts-example.tex > $COMPILE_OPT; break;;
            [Nn]* ) echo "Please manually setup compile options."; exit;;
            * ) echo "Invalid input. Please answer yes or no.";;
        esac
    done
fi

perl compile-thesis-from-scratch.pl compile-opts.tex