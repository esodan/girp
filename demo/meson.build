girp_sources = [
  'main.vala',
  'window.vala',
  'girpui-doc.vala',
  'girpui-object-details.vala',
  'girpui-object.vala'
]

girp_deps = [
  dependency('gio-2.0', version: '>= 2.50'),
  dependency('gtk+-3.0', version: '>= 3.22'),
  dependency('gxml-0.16', version: '>= 0.15.2')
]


gnome = import('gnome')

girp_sources += gnome.compile_resources('girp-resources',
  'girp.gresource.xml',
  c_name: 'girp'
)

executable('girp', girp_sources,
  vala_args: '--target-glib=2.50',
  dependencies: girp_deps,
  link_with: libgirp,
  install: true,
)
