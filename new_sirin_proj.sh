#! /bin/sh

# nb: in emacs, use C-q TAB to insert a tab character

name=$1

# FIXME.  This does not halt on csound errors.

m4_input='
sirin = mzscheme /home/amoe/code/sirin/test.scm

all: _name.orc _name.srn
	$(sirin) _name.srn > _name.sco
	tmp=$$(mktemp); \
	  csound -ndo _name.wav _name.orc _name.sco 2>&1 | tee "$$tmp" \
	  && grep -v \
	  "overall samples out of range:[[:space:]]*0[[:space:]][[:space:]]*0" \
	  "$$tmp"
	mplayer _name.wav
'

if [ -z "$1" ]; then
    echo "Please give me the project name as the first argument."
    exit 2
fi 

echo "$m4_input" | m4 -D_name="$1" > "$name.mk"
echo "; $name.srn" > "$name.srn"
echo "; $name.orc" > "$name.orc"
