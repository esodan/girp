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
      try {
        initialize ("repository");
        set_attribute_ns ("http://www.w3.org/2000/xmlns",
                        "xmlns", "http://www.gtk.org/introspection/core/1.0");
        set_attribute_ns ("http://www.w3.org/2000/xmlns",
                        "xmlns:c", "http://www.gtk.org/introspection/c/1.0");
        set_attribute_ns ("http://www.w3.org/2000/xmlns",
                          "xmlns:glib", "http://www.gtk.org/introspection/glib/1.0");
        version = "1.2";
      } catch (GLib.Error e) { warning ("Error: "+e.message); }
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
    [Description (nick="::name")]
    public string name { get; set; }
    [Description (nick="::version")]
    public string version { get; set; }
    [Description (nick="::c:prefix")]
    public string cprefix { get; set; }
    Class.Map _classes;
    public Class.Map classes {
      get {
        if (_classes == null)
          set_instance_property ("classes");
        return _classes;
      }
      set {
        if (_classes != null) {
          try {
            clean_property_elements ("classes");
          } catch (GLib.Error e) { warning ("Error: "+e.message); }
        }
        _classes = value;
      }
    }
    Interface.Map _interfaces;
    public Interface.Map interfaces {
      get {
        if (_interfaces == null)
          set_instance_property ("interfaces");
        return _interfaces;
      }
      set {
        if (_interfaces != null) {
          try {
            clean_property_elements ("interfaces");
          } catch (GLib.Error e) { warning ("Error: "+e.message); }
        }
        _interfaces = value;
      }
    }
    construct {
      try {
        initialize ("namespace");
        _classes = new Class.Map ();
        _classes.initialize_element (this);
      } catch (GLib.Error e) { warning ("Error: "+e.message); }
    }
 }
 public class Girp.GObject : GomElement, MappeableElement
 {
    [Description (nick="::name")]
    public string name { get; set; }
    [Description (nick="::c:type")]
    public string ctype { get; set; }
    [Description (nick="::glib:type-name")]
    public string type_name { get; set; }
    [Description (nick="::glib:get-type")]
    public string get_type_method { get; set; }
    [Description (nick="::glib:type-struct")]
    public string type_struct { get; set; }
    [Description (nick="::parent")]
    public string giparent { get; set; }
    public Doc doc { get; set; }


    Property.Map _properties;
    public Property.Map properties {
      get {
        if (_properties == null)
          set_instance_property ("properties");
        return _properties;
      }
      set {
        if (_properties != null) {
          try {
            clean_property_elements ("properties");
          } catch (GLib.Error e) { warning ("Error: "+e.message); }
        }
        _properties = value;
      }
    }

    Method.Map _methods;
    public Method.Map methods {
      get {
        if (_methods == null)
          set_instance_property ("methods");
        return _methods;
      }
      set {
        if (_methods != null) {
          try {
            clean_property_elements ("methods");
          } catch (GLib.Error e) { warning ("Error: "+e.message); }
        }
        _methods = value;
      }
    }
    Function.Map _functions;
    public Function.Map functions {
      get {
        if (_functions == null)
          set_instance_property ("functions");
        return _functions;
      }
      set {
        if (_functions != null) {
          try {
            clean_property_elements ("functions");
          } catch (GLib.Error e) { warning ("Error: "+e.message); }
        }
        _functions = value;
      }
    }
    construct {
      parse_children = false;
    }

    public string get_map_key () { return name; }
 }
 public class Girp.Interface : GObject
 {
    construct {
      try {
        initialize ("interface");
      } catch (GLib.Error e) { warning ("Error: "+e.message); }
    }

    public class Map : GomHashMap {
      construct {
        try {
          initialize (typeof (Girp.Interface));
        } catch (GLib.Error e) { warning ("Error: "+e.message); }
      }
    }
 }
 public class Girp.Class : GObject
 {
    construct {
      initialize ("class");
    }
    public class Map : GomHashMap {
      construct {
        try {
          initialize (typeof (Girp.Class));
        } catch (GLib.Error e) { warning ("Error: "+e.message); }
      }
    }
 }
 public class Girp.MethodCommon : GomElement, MappeableElement
 {
    [Description (nick="::name")]
    public string name { get; set; }
    [Description (nick="::c:identifier")]
    public string cidentifier { get; set; }
    [Description (nick="::version")]
    public string version { get; set; }
    public ReturnValue return_value { get; set; }
    public Doc doc { get; set; }

    construct {
      parse_children = false;
    }

    public string get_map_key () { return name; }
 }
 public class Girp.Property : GomElement, MappeableElement
 {
    [Description (nick="::name")]
    public string name { get; set; }
    [Description (nick="::writable")]
    public string writable { get; set; }
    public ValueType value_type { get; set; }
    construct {
      initialize ("property");
      parse_children = false;
    }

    public class Map : GomHashMap {
      construct {
        try {
          initialize (typeof (Girp.Property));
        } catch (GLib.Error e) { warning ("Error: "+e.message); }
      }
    }
    public string get_map_key () { return name; }
 }
 public class Girp.Method : MethodCommon
 {
    construct {
      try {
        initialize ("method");
      } catch (GLib.Error e) { warning ("Error: "+e.message); }
    }

    public class Map : GomHashMap {
      construct {
        try {
          initialize (typeof (Girp.Method));
        } catch (GLib.Error e) { warning ("Error: "+e.message); }
      }
    }
 }
 public class Girp.Function : MethodCommon
 {
    construct {
      try {
        initialize ("function");
      } catch (GLib.Error e) { warning ("Error: "+e.message); }
    }

    public class Map : GomHashMap {
      construct {
        try {
          initialize (typeof (Girp.Function));
        } catch (GLib.Error e) { warning ("Error: "+e.message); }
      }
    }
 }
 public class Girp.Constructor : MethodCommon
 {
    construct {
      try {
        initialize ("constructor");
      } catch (GLib.Error e) { warning ("Error: "+e.message); }
    }

    public class Map : GomHashMap {
      construct {
        try {
          initialize (typeof (Girp.Constructor));
        } catch (GLib.Error e) { warning ("Error: "+e.message); }
      }
    }
 }
 public class Girp.ReturnValue : GomElement
 {
    [Description (nick="::transfer-ownership")]
    public string transfer_ownership { get; set; }
    public ValueType value_type { get; set; }
    construct {
      try {
        initialize ("return-value");
      } catch (GLib.Error e) { warning ("Error: "+e.message); }
    }
 }
 public class Girp.ValueType : GomElement
 {
    [Description (nick="::name")]
    public string name { get; set; }
    [Description (nick="::c:type")]
    public string ctype { get; set; }
    construct {
      initialize ("type");
    }
 }
 public class Girp.Doc : GomElement
 {
    [Description (nick="::xml:space")]
    public string space { get; set; }
    public string text {
      owned get {
        return text_content;
      }
    }
    construct {
      try {
        initialize ("doc");
      } catch (GLib.Error e) { warning ("Error: "+e.message); }
    }
 }
