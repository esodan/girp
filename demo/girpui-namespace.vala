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
using GXml;

[GtkTemplate (ui = "/org/gnome/Girp/namespace.ui")]
public class Girpui.Namespace : Gtk.Grid {
  [GtkChild]
  private Gtk.Entry ename;
  [GtkChild]
  private Gtk.ListBox lbobjects;

  private GLib.ListStore objects;

  public Girp.Repository rep { get; set; }

  public signal void object_activated (GLib.Object obj);

  construct {
    objects = new GLib.ListStore (typeof (GLib.Object));
    lbobjects.bind_model (objects, (obj)=>{
      var w = new ObjectDetails ();
      w.object = obj;
      w.update ();
      w.show_details.connect (()=>{
        object_activated (w.object as GLib.Object);
      });
      return w;
    });
    lbobjects.row_activated.connect ((row)=>{
      var o = row.get_child () as Girpui.ObjectDetails;
      if (o == null) return;
      if (o.object == null) return;
      object_activated (o);
    });
  }
  public void update () {
    ename.text = "";
    objects.remove_all ();
    if (rep == null) return;
    if (rep.ns == null) return;
    if (rep.ns.name != null)
      ename.text = rep.ns.name;
    foreach (DomNode n in rep.ns.child_nodes) {
      if (!(n is Girp.GObject)) continue;
      objects.append (n);
    }
  }
}
