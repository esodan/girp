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

[GtkTemplate (ui = "/org/gnome/Girp/object-details.ui")]
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

  public GLib.Object object { get; set; }

  construct {
    wobject = new Girpui.Object ();
    box.add (wobject);
    tbdetails.clicked.connect (()=>{
      if (tbdetails.active)
        rdetails.reveal_child = true;
      else
        rdetails.reveal_child = false;
    });
  }
  public void update () {
    lname.label = "";
    if (object == null) return;
    if (object is Named) {
      if ((object as Named).name != null)
        lname.label = (object as Named).name;
    }
    rdetails.reveal_child = false;
    if (!(object is GObject)) return;
    wobject.object = object as GObject;
    wobject.update ();
  }
}
