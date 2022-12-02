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
           (1 => new String'("Javier's Wife"),
            2 => new String'("Javier's Sons")));

    Gtk.About_Dialog.Set_Authors
       (V_Dialog,
        (1 => new String'("Javier Fuica Fernandez <jafuica@gmail.com>"),
         2 => new String'("Manuel Gomez <mgrojo@gmail.com>")));

    Gtk.About_Dialog.Set_Comments (V_Dialog, "Bingo application in GTKAda");

    Gtk.About_Dialog.Set_License
      (V_Dialog,
       "Permission is hereby granted, free of charge, to any person obtaining a copy "
         & "of this software and associated documentation files (the ""Software""), to deal "
         & "in the Software without restriction, including without limitation the rights "
         & "to use, copy, modify, merge, publish, distribute, sublicense, and/or sell "
         & "copies of the Software, and to permit persons to whom the Software is "
         & "furnished to do so, subject to the following conditions: "
         & ASCII.LF & ASCII.LF
         & "The above copyright notice and this permission notice shall be included in all "
         & "copies or substantial portions of the Software. "
         & ASCII.LF & ASCII.LF
         & "THE SOFTWARE IS PROVIDED ""AS IS"", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR "
         & "IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, "
         & "FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE "
         & "AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER "
         & "LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, "
         & "OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE "
         & "SOFTWARE");

    Gtk.About_Dialog.Set_Wrap_License (V_Dialog, True);

    Gtk.About_Dialog.Set_Program_Name (V_Dialog, "BingAda");

    Gtk.About_Dialog.Set_Version (V_Dialog, "1.0");

    if Gtk.About_Dialog.Run (V_Dialog) /= Gtk.Dialog.Gtk_Response_Close then
      --  Dialog was destroyed by user, not closed through Close button
      null;
    end if;

    Gtk.About_Dialog.Destroy (V_Dialog);


  end P_Show_Window;

  --==================================================================

end Q_Bingo_Help;
