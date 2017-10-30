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
    Test.add_func ("/girp/repository",
    ()=>{
      try {
        var gir = new Girp.Repository ();
        var f = GLib.File.new_for_path ("tests/Girp.gir");
        message (f.get_path ());
        assert (f.query_exists ());
        gir.read_from_file (f);
        assert (gir.ns != null);
        assert (gir.ns.name == "Girp");
        assert (gir.ns.version == "0.2");
        message (gir.get_attribute ("prefix"));
        assert (gir.ns.cprefix == "Girp");
        assert (gir.ns.classes.length > 0);
        //warning (gir.write_string ());
      } catch (GLib.Error e) { warning ("Error: "+e.message); }
    });
    return Test.run ();
  }
}
