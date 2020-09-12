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

- Colors configurable using bingada.css

# Dependencies

- GtkAda: independently installed
- canberra-ada: used as a git submodule

In order to build libcanberra (only for Linux):

```
git clone --recursive https://github.com/jfuica/bingada
cd libs/canberra-ada
make
```

Required packages are listed in https://github.com/onox/canberra-ada

# Linux/Windows Install using GNAT Community Edition

- Install the GNAT Community Edition for your Operating System version.

- Install GtkAda Community Edition and set the default path where you installed
  the gnat.

- You might need to adjust bingada.gpr, like setting the path to your gtkada.gpr file or removing the line importing the canberra-ada project, since it is not supported in Windows (see issue #11).

- You can open the gtkada.gpr file using GPS, or compile with gprbuild -p bingada

- You need to copy GtkAda DLL files to your execution directory to run bingada.

# Installation under Ubuntu 16.04 using FSF GNAT

- Install the following packages:
```
sudo apt install gprbuild gnat libgtkada16.1.0-dev
```
- Build with:
```
gprbuild -p bingada
```
- Run directly like this:
```
./obj/bingada
```
- Or you can install "bombo.png", "media" directory, bingada.css and "bingada" to any location and run from there.

# Wishes / TODO


The interface is really simple, and it could be improved, but, I think the main goals could be:

- Cards shown in a table.

- Get better recording of numbers for each language.

- Include status message (Stop/start..)

- Configure Other options.

# Attribution

Audio recordings of numbers have been obtained from:

- [English by NumberOne from Wikimedia Commons](https://commons.wikimedia.org/wiki/Category:English_pronunciation_of_numbers)
- [German from Wikimedia Commons](https://commons.wikimedia.org/wiki/Category:German_pronunciation_of_numbers)
- [Spanish by Sergeeo from freesound.org](https://freesound.org/people/sergeeo/sounds/177270/)
