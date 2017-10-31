/* -*- Mode: vala; indent-tabs-mode: nil; c-basic-offset: 2; tab-width: 2 -*-  */
/*
 * gsvg-test.vala

 * Copyright (C) 2017 Daniel Espinosa <esodan@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
using Girp;
using GXml;

class GirpTest.Suite : Object
{
  static int main (string args[])
  {
    GLib.Intl.setlocale (GLib.LocaleCategory.ALL, "");
    Test.init (ref args);
    Test.add_func ("/girp/repository/gio",
    ()=>{
      try {
        var gir = new Girp.Repository ();
        var f = GLib.File.new_for_path ("tests/Gio-2.0.gir");
        message (f.get_path ());
        assert (f.query_exists ());
        gir.read_from_file (f);
        assert (gir.ns != null);
        assert (gir.ns.name == "Gio");
        assert (gir.ns.version == "2.0");
        assert (gir.ns.classes.length > 0);
        assert (gir.ns.interfaces.length > 0);
        var c1 = gir.ns.classes.get_item (0) as Girp.Class;
        assert (c1 != null);
        message (c1.name);
        assert (c1.doc != null);
        var app = gir.ns.classes.get ("Application") as Girp.Class;
        assert (app != null);
        assert (app.functions.length > 0);
        assert (app.properties.length > 0);
        assert (app.methods.length > 0);
        var m1 = app.methods.get_item (0) as Girp.Method;
        assert (m1 != null);
        message (app.name+":"+m1.name);
        warning (m1.doc.text);
      } catch (GLib.Error e) { warning ("Error: "+e.message); }
    });
    return Test.run ();
  }
}
