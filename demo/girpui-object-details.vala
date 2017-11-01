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
  private Gtk.Button bdetails;
  [GtkChild]
  private Gtk.Image image;

  public GLib.Object object { get; set; }

  public signal void show_details ();

  construct {
    bdetails.clicked.connect (()=>{
      show_details ();
    });
  }
  public void update () {
    lname.label = "";
    if (object == null) return;
    if (object is Named) {
      if ((object as Named).name != null)
        lname.label = (object as Named).name;
    }
    image.icon_name = "gtk-convert"; // FIXME: Set based on type
  }
}
