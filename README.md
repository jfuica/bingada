# bingada
=========

Bingo application in GTKAda

This is a simple bingo application called BingAda (Bingo + Ada), to play bingo at home with your family during this COVID19 "stay at home" time.


The Bingo is fully functional, you can :

- Start a new game.

- Play bingo manually, clicking in the bingo image button.

- Play bingo automatically.

- Stop/Start the bingo.

- Check Cards. They are read from a file called bingo_cards.csv.


#Linux/Windows Install
=====================

- Install de GNAT Community Edition for your windows version.

- Install GTKAda Comunity Edition and set the default path where you installed
  the gnat.

- For gtkada I set C:/GNAT/2019/gtkada (The previous gnat path is needed to be
set, because the gtkada needs to be compile).

- You can open the gtkada.gpr file using GPS, or compile with gprbuild -p bingada


#Wishes / TODO
==============

The interface is really simple, and It could be improved, but, I think the main goals could be :

- Cards shown in a table.

- Use soundcard to hear the Numbers.

- Include status message (Stop/start..)

- Configure Colors with colors.css

- Configure Other options.



