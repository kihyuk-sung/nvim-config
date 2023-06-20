local jdtls_path = vim.fn.stdpath('data') .. '/mason/packages/jdtls'
local system = 'mac'
local config_path = jdtls_path .. '/config_' .. system
local plugin_path = jdtls_path .. '/plugins'
local path_to_jar = plugin_path .. '/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar'
local home = vim.env.HOME
local java_home = home .. '/.sdkman/candidates/java'
local jdk17_path = java_home .. '/17.0.7-tem'
local jdk11_path = java_home .. '/11.0.19-tem'
local jdk_home = java_home .. '/20.0.1-tem'

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_path = vim.fn.stdpath('data') .. '/site/java/workspace_root/' .. project_name
os.execute('mkdir ' .. workspace_path)

local config = {
  cmd = {
    jdk_home .. '/bin/java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

    '-jar', path_to_jar,
    '-configuration', config_path,
    '-data', workspace_path,
  },
  root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
  settings = {
    java = {
      home = jdk_home,
      signatureHelp = { enabled = true },
      import = { enabled = true },
      rename = { enabled = true },
      configuration = {
        runtimes = {
          {
            name = 'JavaSE-11',
            path = jdk11_path,
          },
          {
            name = 'JavaSE-17',
            path = jdk17_path,
          },
        }
      }
    }
  },
  init_options = { bundles = {} },
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
}

require('jdtls').start_or_attach(config)
