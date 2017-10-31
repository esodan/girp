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

[GtkTemplate (ui = "/org/gnome/Girp/object.ui")]
public class Girpui.Object : Gtk.Grid {
  [GtkChild]
  private Gtk.ListBox lbdetails;

  private GLib.ListStore members;

  public Girp.GObject object { get; set; }

  construct {
    members = new GLib.ListStore (typeof (GLib.Object));
    lbdetails.bind_model (members, (obj)=>{
      var w = new MemberRow ();
      w.object = obj;
      w.update ();
      return w;
    });
  }
  public void update () {
    if (object == null) return;
    if (object is GObject)
      foreach (DomNode n in (object as DomNode).child_nodes) {
        if (!(n is GObject)) continue;
        members.append (n);
      }
  }
}

[GtkTemplate (ui = "/org/gnome/Girp/member-row.ui")]
public class Girpui.MemberRow : Gtk.Grid {
  [GtkChild]
  private Gtk.Button bmember;
  [GtkChild]
  private Gtk.Label lname;
  [GtkChild]
  private Gtk.Image image;
  [GtkChild]
  private Gtk.Popover pdoc;

  private Girpui.Doc doc;

  public GLib.Object object { get; set; }

  construct {
    doc = new Girpui.Doc ();
    pdoc.add (doc);
    bmember.clicked.connect (()=>{
      pdoc.popup ();
    });
  }

  public void update () {
    if (object == null) return;
    if (object is GObject) {
      // FIXME: Choose a correct icon for object
      image.icon_name = "gtk-convert";
    }
    if (object is Girp.Named) {
      var go = object as Girp.Named;
      if (go.name != null)
        lname.label = go.name;
    }
    if (object is Girp.Documented) {
      doc.doc = (object as Documented).doc;
      doc.update ();
    }
  }
}
