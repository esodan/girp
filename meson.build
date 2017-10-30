project('girp','c', 'vala',
  version: '0.1.0',
  meson_version: '>= 0.40.0',
)
i18n = import('i18n')

PROJECT_NAME = meson.project_name()
API_VERSION = '0.2'
PROJECT_VERSION = meson.project_version()
VERSIONED_PROJECT_NAME = PROJECT_NAME+'-'+API_VERSION
CAMEL_CASE_NAME = 'Girp'
VERSIONED_CAMEL_CASE_NAME = CAMEL_CASE_NAME +'-'+ API_VERSION

VALADEPS = 'gxml-0.16'
PCDEPS = 'gxml-0.16'

inc_rooth = include_directories ('.')
inc_rooth_dep = declare_dependency (include_directories : inc_rooth)

subdir('data')
subdir('src')
subdir('po')
subdir('tests')
meson.add_install_script('build-aux/meson/postinstall.py')
