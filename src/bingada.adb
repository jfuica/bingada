with Gtk.Main;
with Q_Bingada;

with Ada.Directories;
with Ada.Environment_Variables;

procedure Bingada is

begin

   -- Set current directory to the APPDIR value path. In this way we
   -- allow running from an AppImage and still find the resource files.
   --
   if Ada.Environment_Variables.Exists ("APPDIR") then
      Ada.Directories.Set_Directory
        (Ada.Environment_Variables.Value ("APPDIR"));
   end if;

   Gtk.Main.Init;

   Q_Bingada.P_Create_Widgets;

   -- All GTK applications must have a Gtk.Main.Main. Control ends here
   -- and waits for an event to occur (like a key press or a mouse event),
   -- until Gtk.Main.Main_Quit is called.
   Gtk.Main.Main;

end Bingada;
