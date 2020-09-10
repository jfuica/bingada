with Gtk.Main;
with Q_Bingada;

procedure Bingada is

begin

   Gtk.Main.Init;

   Q_Bingada.P_Create_Widgets;

   -- All GTK applications must have a Gtk.Main.Main. Control ends here
   -- and waits for an event to occur (like a key press or a mouse event),
   -- until Gtk.Main.Main_Quit is called.
   Gtk.Main.Main;

end Bingada;
