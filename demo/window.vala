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
  private Gtk.Box box;

  private Girpui.Namespace ns;

  construct {
    ns = new Girpui.Namespace ();
    box.add (ns);
    fchooser.file_set.connect (()=>{
      try {
        var ons = new Girp.Repository ();
        ons.read_from_file (fchooser.get_file ());
        ns.rep = ons;
        ns.update ();
      } catch (GLib.Error e) { warning ("Error: %s".printf (e.message)); }
    });
  }

  public Window (Gtk.Application app) {
    Object (application: app);
  }
}
