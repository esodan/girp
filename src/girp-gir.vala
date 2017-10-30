/* -*- Mode: vala; indent-tabs-mode: nil; c-basic-offset: 2; tab-width: 2 -*- */
/* gsvg-dom-element.vala
 *
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

 using GXml;

 public class Girp.Repository : GomElement
 {
    [Description (nick="::version")]
    public string version { get; set; }

    public Namespace ns { get; set; }

    construct {
      initialize ("repository");
      set_attribute_ns ("http://www.w3.org/2000/xmlns",
                      "xmlns", "http://www.gtk.org/introspection/core/1.0");
      set_attribute_ns ("http://www.w3.org/2000/xmlns",
                      "xmlns:c", "http://www.gtk.org/introspection/c/1.0");
      set_attribute_ns ("http://www.w3.org/2000/xmlns",
                        "xmlns:glib", "http://www.gtk.org/introspection/glib/1.0");
      version = "1.2";
    }
 }

 public class Girp.Include : GomElement
 {
    [Description (nick="::name")]
    public string name { get; set; }
    [Description (nick="::version")]
    public string version { get; set; }

    construct {
      initialize ("include");
    }
 }

 public class Girp.CInclude : GomElement
 {
    [Description (nick="::name")]
    public string name { get; set; }

    construct {
      initialize_with_namespace ("http://www.gtk.org/introspection/c/1.0",
                                "c", "include");
    }
 }

 public class Girp.Namespace : GomElement
 {
    Class.Map _classes;
    [Description (nick="::name")]
    public string name { get; set; }
    [Description (nick="::version")]
    public string version { get; set; }
    [Description (nick="::c:prefix")]
    public string cprefix { get; set; }
    public Class.Map classes {
      get {
        if (_classes == null)
          set_instance_property ("classes");
        return _classes;
      }
      set {
        if (_classes != null)
          clean_property_elements ("classes");
        _classes = value;
      }
    }
    construct {
      initialize ("namespace");
      _classes = new Class.Map ();
      _classes.initialize_element (this);
    }
 }
 public class Girp.Class : GomElement, MappeableElement
 {
    [Description (nick="::name")]
    public string name { get; set; }
    [Description (nick="::version")]
    public string version { get; set; }
    [Description (nick="::c:prefix")]
    public string prefix { get; set; }

    construct {
      initialize ("class");
    }

    public string get_map_key () { return name; }
    public class Map : GomHashMap {
      construct {
        initialize (typeof (Girp.Class));
      }
    }
 }
