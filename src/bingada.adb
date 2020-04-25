with GTK.MAIN;
with Q_BINGADA;

procedure BINGADA is
   
begin
   
   GTK.MAIN.INIT;
   
   Q_BINGADA.P_CREATE_WIDGETS;
   
   -- All GTK applications must have a Gtk.Main.Main. Control ends here
   -- and waits for an event to occur (like a key press or a mouse event),
   -- until Gtk.Main.Main_Quit is called.
   GTK.MAIN.MAIN;
   
end BINGADA;
