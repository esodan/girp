/* -*- Mode: vala; indent-tabs-mode: nil; c-basic-offset: 2; tab-width: 2 -*- */
/* girpui-class-details.vala
 *
 * Copyright (C) 2017 PWMC Services
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

using Girp;

[GtkTemplate (ui = "/org/gnome/Girp/class-details.ui")]
public class Girpui.ObjectDetails : Gtk.Grid {
  [GtkChild]
  private Gtk.Label lname;
  [GtkChild]
  private Gtk.ToggleButton tbdetails;
  [GtkChild]
  private Gtk.Revealer rdetails;
  [GtkChild]
  private Gtk.Box box;

  private Girpui.Object wobject;

  public Girp.GObject object { get; set; }
  construct {
    lname = "";
    wobject = new Girpui.Object ();
    box.add (wobject);
    tbdetails.clicked.connect (()=>{
      if (tbdetails.active)
        rdetails.child_revealed = true;
      else
        rdetails.child_revealed = false;
    });
  }
  public void update () {
    try {
      if (object == null) return;
      lname.label = object.name;
      rdetails.child_revealed = false;
      wobject.object = object;
      wobject.update ();
    } catch (GLib.Error e) { warning ("Error: %s").printf (e.message); }
  }
}
