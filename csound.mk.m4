dnl  Invoke me with -Dfile=

all: _file.orc _file.sco
	csound --nodisplays -o _file.wav _file.orc _file.sco
	mplayer _file.wav
