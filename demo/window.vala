/* -*- Mode: vala; indent-tabs-mode: nil; c-basic-offset: 2; tab-width: 2 -*- */
/* window.vala
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

[GtkTemplate (ui = "/org/gnome/Girp/window.ui")]
public class GirpApp.Window : Gtk.ApplicationWindow {
  [GtkChild]
  private Gtk.FileChooserButton fchooser;
  [GtkChild]
  private Gtk.Box bxns;
  [GtkChild]
  private Gtk.Box bxobject;
  [GtkChild]
  private Gtk.Stack stack;
  [GtkChild]
  private Gtk.Button bback;

  private Girpui.Namespace ns;
  private Girpui.Object object_details;

  construct {
    ns = new Girpui.Namespace ();
    bxns.add (ns);
    object_details = new Girpui.Object ();
    bxobject.add (object_details);
    fchooser.file_set.connect (()=>{

      load.begin (fchooser.get_file ());
    });
    ns.object_activated.connect ((obj)=>{
      if (!(obj is GObject)) return;
      object_details.object = obj as GObject;
      object_details.update ();
      stack.visible_child_name = "object";
    });
    bback.clicked.connect (()=>{
      stack.visible_child_name = "namespace";
    });
  }

  public Window (Gtk.Application app) {
    Object (application: app);
  }

  private async void load (GLib.File f) {
    try {
      var ons = new Girp.Repository ();
      yield ons.read_from_file_async (fchooser.get_file ());
      ns.rep = ons;
      ns.update ();
    } catch (GLib.Error e) { warning ("Error: %s".printf (e.message)); }
  }
}
