testdirs_dep = declare_dependency (compile_args : [
	'-DTEST_DIR="'+join_paths (meson.source_root (),'tests')+'"',
	'-DTEST_SAVE_DIR="'+join_paths (meson.build_root (),'tests')+'"',
])

conf = configuration_data ()
configure_file (input: 'Girp.gir',
		output: 'Girp.gir',
		configuration: conf)

configure_file (input: 'Gio-2.0.gir',
		output: 'Gio-2.0.gir',
		configuration: conf)

files_tests_gir = ([
		'girp-gir-test.vala'
	])

tgir = executable('gir_tests', files_tests_gir,
	vala_args : [],
	dependencies : [ libgirp_deps, inc_libh_dep, testdirs_dep, inc_rooth_dep],
	link_with: libgirp
)
test ('gir', tgir)

files_tests_performance = ([
		'girp-performance.vala'
	])

tperf = executable('gir_performance', files_tests_performance,
	vala_args : [],
	dependencies : [ libgirp_deps, inc_libh_dep, testdirs_dep, inc_rooth_dep],
	link_with: libgirp
)
test ('performance', tperf)
