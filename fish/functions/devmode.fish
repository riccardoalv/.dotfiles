set GIT_REPOSITORY $(basename $(git remote get-url origin) .git )

function devmode
    echo '
    local null_ls = require("null-ls")
    local lspconfig = require("lspconfig")

    local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

    lspconfig.clangd.setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })

    null_ls.setup({
        sources = {
            null_ls.builtins.formatting.clang_format,
        },
    })
    ' >> .nvim.lua

    echo '
    { pkgs ? import <nixpkgs> { } }:
    with pkgs;

    mkShell {
      name = "$GIT_REPOSITORY";

      # Add executable packages to the nix-shell environment.
      packages = with pkgs; [
        gnumake
      ];

      # Bash statements that are executed by nix-shell.
      shellHook = ''
          export DEBUG=1
      '';

      MY_ENVIRONMENT_VARIABLE = "world";

      # nix-ld
      programs.nix-ld.enable = true;
      environment.variables = {
        NIX_LD_LIBRARY_PATH = lib.makeLibraryPath packages;
        NIX_LD = pkgs.binutils.dynamicLinker;
      };
    }
    ' >> shell.nix

    echo "Remember to Edit shell.nix"
end
