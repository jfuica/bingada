--*****************************************************************************
--*
--* PROJECT:            BingAda
--*
--* FILE:               q_bingo_help.adb
--*
--* AUTHOR:             Javier Fuica Fernandez
--*
--*****************************************************************************

with GTK.ABOUT_DIALOG;
with GTK.DIALOG;

package body Q_BINGO_HELP is

  use type GTK.DIALOG.GTK_RESPONSE_TYPE;

  --==================================================================

  procedure P_SHOW_WINDOW (V_PARENT_WINDOW : GTK.WINDOW.GTK_WINDOW) is

    V_DIALOG : GTK.ABOUT_DIALOG.GTK_ABOUT_DIALOG;

  begin

    GTK.ABOUT_DIALOG.GTK_NEW (V_DIALOG);

    GTK.ABOUT_DIALOG.SET_TRANSIENT_FOR (V_DIALOG, V_PARENT_WINDOW);

    GTK.ABOUT_DIALOG.SET_DESTROY_WITH_PARENT (V_DIALOG, TRUE);

    GTK.ABOUT_DIALOG.SET_MODAL (V_DIALOG, TRUE);

    GTK.ABOUT_DIALOG.ADD_CREDIT_SECTION
       (About        => V_DIALOG,
        Section_Name => "Beta Testers : ",
        People       =>
           (1 => new STRING'("Wife"),
            2 => new STRING'("Sons")));

    GTK.ABOUT_DIALOG.SET_AUTHORS
       (V_Dialog,
        (1 => new String'("Javier Fuica Fernandez <jafuica@gmail.com>")));

    GTK.ABOUT_DIALOG.Set_Comments (V_Dialog, "Bingo application in GTKAda");

    GTK.ABOUT_DIALOG.SET_LICENSE
       (V_Dialog,
        "This library is free software; you can redistribute it and/or"
           & " modify it under the terms of the GNU General Public"
           & " License as published by the Free Software Foundation; either"
           & " version 2 of the License, or (at your option) any later version."
           & ASCII.LF
           & "This library is distributed in the hope that it will be useful,"
           & " but WITHOUT ANY WARRANTY; without even the implied warranty of"
           & " MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the"
           & " GNU General Public License for more details.");

    GTK.ABOUT_DIALOG.SET_WRAP_LICENSE (V_Dialog, True);

    GTK.ABOUT_DIALOG.SET_PROGRAM_NAME (V_Dialog, "BingAda");

    GTK.ABOUT_DIALOG.SET_VERSION (V_Dialog, "0.9 Beta");

    if GTK.ABOUT_DIALOG.Run (V_Dialog) /= GTK.DIALOG.GTK_RESPONSE_CLOSE then
      --  Dialog was destroyed by user, not closed through Close button
      null;
    end if;

    GTK.ABOUT_DIALOG.Destroy (V_Dialog);

     --GTK.ABOUT_DIALOG.ON_ACTIVATE_LINK (V_DIALOG,P_ON_ACTIVATE_LINK'Access);

    --GTK.ABOUT_DIALOG.DESTROY (V_DIALOG);

  end P_SHOW_WINDOW;

  --==================================================================

end Q_BINGO_HELP;
