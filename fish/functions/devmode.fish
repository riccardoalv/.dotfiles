set GIT_REPOSITORY (basename (git remote get-url origin) .git )

function devmode
  echo '
    local null_ls = require("null-ls")
    local lspconfig = require("lspconfig")
    local opts = { noremap = true, silent = true }
    local keymap = vim.keymap.set
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.eslint,
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.code_actions.eslint,
      },
    })

    lspconfig.tsserver.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    }) ' >> .nvim.lua

    echo '
{
  description = "NixOS environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

  in {
    devShell.${system} = with pkgs;

      mkShell rec {
        packages = [
          openssl
          pkg-config
        ];
        shellHook = ''
        export PRISMA_SCHEMA_ENGINE_BINARY="${prisma-engines}/bin/schema-engine"
        export PRISMA_QUERY_ENGINE_BINARY="${prisma-engines}/bin/query-engine"
        export PRISMA_QUERY_ENGINE_LIBRARY="${prisma-engines}/lib/libquery_engine.node"
        export PRISMA_FMT_BINARY="${prisma-engines}/bin/prisma-fmt"
        '';
      };

  };
}' >> flake.nix

    echo "Remember to Edit flake.nix"
end
