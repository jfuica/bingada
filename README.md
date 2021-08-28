![Ada (GNAT)](https://github.com/jfuica/bingada/workflows/Ada%20(GNAT)/badge.svg)
![BingAda](https://raw.githubusercontent.com/jfuica/bingada/master/bombo.png "BingAda icon")

# bingada

Bingo application in GtkAda

This is a simple bingo application called BingAda (Bingo + Ada), to play bingo at home with your family during this COVID19 "stay at home" time.


The Bingo is fully functional, you can:

- Start a new game.

- Play bingo manually, clicking in the bingo image button.

- Play bingo automatically, using "Game > Autospin".

- Stop/Start the bingo.

- Check Cards. They are read from a file called bingo_cards.csv.

- Playback of the numbers (better recordings are needed)

- Translations: English, Spanish, German.

- Colors configurable using `bingada.css`. Two styles provided: light and dark.

# Building with Alire

- Install [Alire](https://alire.ada.dev/)
- Build using `alr build`. All the dependencies are installed and managed by Alire.
- Run directly from `bin/bingada`

The library used for sound in this case is [ASFML](https://github.com/mgrojo/ASFML) available under Linux and Windows.

# Building without Alire
Clone the repository in this way so you get all the dependent submodules:
```
git clone --recursive https://github.com/jfuica/bingada
```

- GtkAda: independently installed
- Sound: three alternative libraries are supported.

You can choose the sound alternative in this way:
`gprbuild -XSOUND_LIB="sfml" -P bingada_custom.gpr`

where the possible values for SOUND_LIB are "asfml" (default), "canberra", "sfml" and "none".

You may need to edit `bingada.gpr` to remove
the sound dependency options ("with" statetements) which won't build in your system.

## Sound: option "asfml"

This option uses the complete Ada binding to SFML provided in
https://github.com/mgrojo/ASFML

asfml can be used as a git submodule.

## Sound: option "canberra"

canberra_ada can be used as a git submodule. In order to build it (only for Linux):

```
cd libs/canberra-ada
make
```
Required packages are listed in https://github.com/onox/canberra-ada

# Sound: option "sfml"

SfmlAudio is a minimal binding to the C++ SFML Audio library and it is
included as part of the project (copied into this repository from
[RufasSock](https://github.com/fastrgv/RufasSok))

sfmlAudio works in both Windows and Linux.

See instructions in libs/sfmlAudio/README.md

## Linux/Windows Install using GNAT Community Edition

- Install the GNAT Community Edition for your Operating System version.

- Install GtkAda Community Edition and set the default path where you installed
  the gnat.

- You might need to adjust `bingada_custom.gpr`, like setting the path to your `gtkada.gpr` file or removing the line importing the canberra-ada project, since it is not supported in Windows (see issue #11).

- You can open the `bingada_custom.gpr` file using GPS, or compile with `gprbuild -p bingada`

- You need to copy GtkAda DLL files to your execution directory to run bingada.

# Installation under Ubuntu using FSF GNAT

- Install the following packages (Ubuntu 16.04):
```
sudo apt install gprbuild gnat libgtkada16.1.0-dev
```
- Install the following packages (Ubuntu 20.04):
```
sudo apt install gprbuild gnat libgtkada19-dev
```
- Build with:
```
gprbuild -p -P bingada_custom
```
- Run directly like this:
```
./bin/bingada
```
- Or you can install using `make install DESTDIR=destination` and run from there.

# Wishes / TODO


The interface is really simple, and it could be improved, but, I think the main goals could be:

- Cards shown in a table.

- Get better recording of numbers for each language.

- Include status message (Stop/start..)

- Configure other options.

# Attribution

Audio recordings of numbers have been obtained from:

- [English by NumberOne from Wikimedia Commons](https://commons.wikimedia.org/wiki/Category:English_pronunciation_of_numbers)
- [German from Wikimedia Commons](https://commons.wikimedia.org/wiki/Category:German_pronunciation_of_numbers)
- [Spanish by Sergeeo from freesound.org](https://freesound.org/people/sergeeo/sounds/177270/)
