# bingada

Bingo application in GTKAda

This is a simple bingo application called BingAda (Bingo + Ada), to play bingo at home with your family during this COVID19 "stay at home" time.


The Bingo is fully functional, you can :

- Start a new game.

- Play bingo manually, clicking in the bingo image button.

- Play bingo automatically, using "Game > Autospin".

- Stop/Start the bingo.

- Check Cards. They are read from a file called bingo_cards.csv.

- Translations: English, Spanish, German.

# Dependencies

- GTKAda: independently installed
- canberra-ada: used as a git submodule

In order to build libcanberra (instructions for Linux):

```
git clone --recursive https://github.com/jfuica/bingada
cd libs/libcanberra
make
```

Required packages are listed in https://github.com/onox/canberra-ada

# Linux/Windows Install using GNAT Community Edition

- Install the GNAT Community Edition for your Operating System version.

- Install GTKAda Community Edition and set the default path where you installed
  the gnat.

- For gtkada I set C:/GNAT/2019/gtkada (The previous gnat path is needed to be
set, because the gtkada needs to be compiled).

- You can open the gtkada.gpr file using GPS, or compile with gprbuild -p bingada

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
- Or you can install "bombo.png" and "bingada" to any location and run from there.

# Wishes / TODO


The interface is really simple, and it could be improved, but, I think the main goals could be :

- Cards shown in a table.

- Use soundcard to hear the Numbers.

- Include status message (Stop/start..)

- Configure Colors with colors.css

- Configure Other options.



