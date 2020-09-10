--*****************************************************************************
--*
--* PROJECT:            BingAda
--*
--* FILE:               q_bingo_help.adb
--*
--* AUTHOR:             Javier Fuica Fernandez
--*
--*****************************************************************************

with Gtk.About_Dialog;
with Gtk.Dialog;

package body Q_Bingo_Help is

  use type Gtk.Dialog.Gtk_Response_Type;

  --==================================================================

  procedure P_Show_Window (V_Parent_Window : Gtk.Window.Gtk_Window) is

    V_Dialog : Gtk.About_Dialog.Gtk_About_Dialog;

  begin

    Gtk.About_Dialog.Gtk_New (V_Dialog);

    Gtk.About_Dialog.Set_Transient_For (V_Dialog, V_Parent_Window);

    Gtk.About_Dialog.Set_Destroy_With_Parent (V_Dialog, True);

    Gtk.About_Dialog.Set_Modal (V_Dialog, True);

    Gtk.About_Dialog.Add_Credit_Section
       (About        => V_Dialog,
        Section_Name => "Beta Testers : ",
        People       =>
           (1 => new String'("Wife"),
            2 => new String'("Sons")));

    Gtk.About_Dialog.Set_Authors
       (V_Dialog,
        (1 => new String'("Javier Fuica Fernandez <jafuica@gmail.com>")));

    Gtk.About_Dialog.Set_Comments (V_Dialog, "Bingo application in GTKAda");

    Gtk.About_Dialog.Set_License
       (V_Dialog,
        "This library is free software; you can redistribute it and/or"
           & " modify it under the terms of the GNU General Public"
           & " License as published by the Free Software Foundation; either"
           & " version 2 of the License, or (at your option) any later version."
           & Ascii.Lf
           & "This library is distributed in the hope that it will be useful,"
           & " but WITHOUT ANY WARRANTY; without even the implied warranty of"
           & " MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the"
           & " GNU General Public License for more details.");

    Gtk.About_Dialog.Set_Wrap_License (V_Dialog, True);

    Gtk.About_Dialog.Set_Program_Name (V_Dialog, "BingAda");

    Gtk.About_Dialog.Set_Version (V_Dialog, "0.9 Beta");

    if Gtk.About_Dialog.Run (V_Dialog) /= Gtk.Dialog.Gtk_Response_Close then
      --  Dialog was destroyed by user, not closed through Close button
      null;
    end if;

    Gtk.About_Dialog.Destroy (V_Dialog);

     --GTK.ABOUT_DIALOG.ON_ACTIVATE_LINK (V_DIALOG,P_ON_ACTIVATE_LINK'Access);

    --GTK.ABOUT_DIALOG.DESTROY (V_DIALOG);

  end P_Show_Window;

  --==================================================================

end Q_Bingo_Help;
