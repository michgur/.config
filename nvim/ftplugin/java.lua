-- JDTLS (Java LSP) configuration
local jdtls = require("jdtls")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.env.HOME .. "/jdtls-workspace/" .. project_name

-- Needed for debugging
local bundles = {
  vim.fn.glob(
    vim.env.HOME .. "/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar"
  ),
}

-- Needed for running/debugging unit tests
vim.list_extend(
  bundles,
  vim.split(vim.fn.glob(vim.env.HOME .. "/.local/share/nvim/mason/share/java-test/*.jar", 1), "\n")
)

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-javaagent:" .. vim.env.HOME .. "/.local/share/nvim/mason/share/jdtls/lombok.jar",
    "-Xmx4g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",

    -- Eclipse jdtls location
    "-jar",
    vim.env.HOME .. "/.local/share/nvim/mason/share/jdtls/plugins/org.eclipse.equinox.launcher.jar",
    "-configuration",
    vim.env.HOME .. "/.local/share/nvim/mason/packages/jdtls/config_mac",
    "-data",
    workspace_dir,
  },

  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "pom.xml", "build.gradle" }),

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  settings = {
    java = {
      home = "/Library/Java/JavaVirtualMachines/jdk-20.jdk/Contents/Home",
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
        -- The runtime name parameters need to match specific Java execution environments.  See https://github.com/tamago324/nlsp-settings.nvim/blob/2a52e793d4f293c0e1d61ee5794e3ff62bfbbb5d/schemas/_generated/jdtls.json#L317-L334
        runtimes = {
          {
            name = "JavaSE-20",
            path = "/Library/Java/JavaVirtualMachines/jdk-20.jdk/Contents/Home",
          },
          {
            name = "JavaSE-21",
            path = "/opt/homebrew/Cellar/openjdk/21.0.2",
          },
        },
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      signatureHelp = { enabled = true },
      format = {
        enabled = true,
        -- Formatting works by default, but you can refer to a specific file/URL if you choose
        settings = {
          url =
          "/Users/michaelgur/Library/Mobile Documents/com~apple~CloudDocs/לימודים/העברית/2024ב/oop/eclipse-formatter.xml",
        },
      },
    },
    completion = {
      favoriteStaticMembers = {
        "org.hamcrest.MatcherAssert.assertThat",
        "org.hamcrest.Matchers.*",
        "org.hamcrest.CoreMatchers.*",
        "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "java.util.Objects.requireNonNullElse",
        "org.mockito.Mockito.*",
      },
      importOrder = {
        "java",
        "javax",
        "com",
        "org",
      },
    },
    extendedClientCapabilities = jdtls.extendedClientCapabilities,
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      toString = {
        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
      },
      useBlocks = true,
    },
  },
  -- Needed for auto-completion with method signatures and placeholders
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  flags = {
    allow_incremental_sync = true,
  },
  init_options = {
    -- References the bundles defined above to support Debugging and Unit Testing
    bundles = bundles,
  },
}

local augroup = vim.api.nvim_create_augroup("LspFormattingJava", {})
local function format_on_save_acmd(client, bufnr)
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = vim.lsp.buf.format,
    })
  end
end
-- Needed for debugging
config["on_attach"] = function(client, bufnr)
  jdtls.setup_dap({ hotcodereplace = "auto" })
  require("jdtls.dap").setup_dap_main_class_configs()
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0, desc = "Go to [D]eclaration" })
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0, desc = "Go to [d]efinition" })
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = 0, desc = "Go to [i]mplementation" })
  vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, { buffer = 0, desc = "Go to [r]eferences" })
  vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { buffer = 0, desc = "Show [s]ignature help" })
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0, desc = "Show [K]ind of symbol" })
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = 0, desc = "Re[n]ame symbol" })
  vim.keymap.set("n", "cd", vim.lsp.buf.rename, { desc = "Change [d]efinition (i.e. rename symbol)" })
  vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code [a]ctions" })

  vim.keymap.set("n", "go", vim.lsp.buf.type_definition, { buffer = 0, desc = "Go to [o]bject type definition" })
  -- vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { buffer = 0, desc = "Jump to signature help." })

  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = 0, desc = "Next [d]iagnostic" })
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = 0, desc = "Previous [d]iagnostic" })

  if vim.lsp.buf.range_code_action then
    vim.keymap.set("x", "<leader>ca", vim.lsp.buf.range_code_action, { buffer = 0, desc = "Range code [a]ctions" })
  else
    vim.keymap.set("x", "<leader>ca", vim.lsp.buf.code_action, { buffer = 0, desc = "Code [a]ctions" })
  end

  vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { buffer = 0, desc = "Format [f]ile" })
  format_on_save_acmd(client, bufnr)
end

vim.cmd("setlocal noexpandtab")
-- This starts a new client & server, or attaches to an existing client & server based on the `root_dir`.
jdtls.start_or_attach(config)
