-- :h mason-default-settings
require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

-- mason-lspconfig uses the `lspconfig` server names in the APIs it exposes - not `mason.nvim` package names
-- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
require("mason-lspconfig").setup({
  -- 确保安装，根据需要填写
  ensure_installed = {
    "bashls",
    "lua_ls",
    "clangd",
    "cmake",
    "pyright",
  },
})

-- 一定要在前面先加载上
local lspconfig = require('lspconfig')

require("mason-lspconfig").setup_handlers({
  function (server_name)
    require("lspconfig")[server_name].setup{}
  end,
  -- Next, you can provide targeted overrides for specific servers.
  ["pyright"] = function()
    lspconfig.pyright.setup{
      settings = {
        python = {
          analysis = {
            typeCheckingMode = 'off',
          }
        }
      }
    }
  end,

  ["lua_ls"] = function ()
    lspconfig.lua_ls.setup {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" }
          }
        }
      }
  }
  end,
  ["clangd"] = function ()
    lspconfig.clangd.setup {
      cmd = {
        "clangd", -- NOTE: 只支持clangd 13.0.0 及其以下版本，新版本会有问题
        "--background-index", -- 后台建立索引，并持久化到disk
        "--compile-commands-dir=build",
        "--clang-tidy", -- 开启clang-tidy
        "--enable-config",
        -- 指定clang-tidy的检查参数， 摘抄自cmu15445. 全部参数可参考 https://clang.llvm.org/extra/clang-tidy/checks
        [[--clang-tidy-checks=-*,
        bugprone-assert-side-effect,
        bugprone-bad-signal-to-kill-thread,
        bugprone-bool-pointer-implicit-conversion,
        bugprone-branch-clone,
        bugprone-copy-constructor-init,
        bugprone-dangling-handle,
        bugprone-dynamic-static-initializers,
        bugprone-exception-escape,
        bugprone-fold-init-type,
        bugprone-forward-declaration-namespace,
        bugprone-forwarding-reference-overload,
        bugprone-implicit-widening-of-multiplication-result,
        bugprone-inaccurate-erase,
        bugprone-incorrect-roundings,
        bugprone-integer-division,
        bugprone-lambda-function-name,
        bugprone-macro-repeated-side-effects,
        bugprone-misplaced-operator-in-strlen-in-alloc,
        bugprone-misplaced-pointer-arithmetic-in-alloc,
        bugprone-misplaced-widening-cast,
        bugprone-move-forwarding-reference,
        bugprone-multiple-statement-macro,
        bugprone-no-escape,
        bugprone-not-null-terminated-result,
        bugprone-parent-virtual-call,
        bugprone-posix-return,
        bugprone-signal-handler,
        bugprone-signed-char-misuse,
        bugprone-sizeof-container,
        bugprone-sizeof-expression,
        bugprone-spuriously-wake-up-functions,
        bugprone-string-constructor,
        bugprone-string-integer-assignment,
        bugprone-string-literal-with-embedded-nul,
        bugprone-stringview-nullptr,
        bugprone-suspicious-enum-usage,
        bugprone-suspicious-include,
        bugprone-suspicious-memory-comparison,
        bugprone-suspicious-memset-usage,
        bugprone-suspicious-missing-comma,
        bugprone-suspicious-semicolon,
        bugprone-suspicious-string-compare,
        bugprone-swapped-arguments,
        bugprone-terminating-continue,
        bugprone-throw-keyword-missing,
        bugprone-too-small-loop-variable,
        bugprone-undefined-memory-manipulation,
        bugprone-undelegated-constructor,
        bugprone-unhandled-exception-at-new,
        bugprone-unhandled-self-assignment,
        bugprone-unused-raii,
        bugprone-unused-return-value,
        bugprone-use-after-move,
        bugprone-virtual-near-miss,
        cert-dcl21-cpp,
        cert-dcl50-cpp,
        cert-dcl58-cpp,
        cert-err33-c,
        cert-err34-c,
        cert-err52-cpp,
        cert-err58-cpp,
        cert-err60-cpp,
        cert-flp30-c,
        cert-mem57-cpp,
        cert-msc50-cpp,
        cert-str34-c,
        cert-oop57-cpp,
        cert-oop58-cpp,
        concurrency-*,
        cppcoreguidelines-init-variables,
        cppcoreguidelines-macro-usage,
        cppcoreguidelines-narrowing-conversions,
        cppcoreguidelines-no-malloc,
        cppcoreguidelines-prefer-member-initializer,
        cppcoreguidelines-pro-bounds-pointer-arithmetic,
        cppcoreguidelines-pro-type-member-init,
        cppcoreguidelines-pro-type-static-cast-downcast,
        cppcoreguidelines-slicing,
        cppcoreguidelines-special-member-functions,
        cppcoreguidelines-virtual-class-destructor,
        fuchsia-multiple-inheritance,
        google-build-explicit-make-pair,
        google-default-arguments,
        google-explicit-constructor,
        google-readability-avoid-underscore-in-googletest-name,
        google-runtime-operator,
        google-upgrade-googletest-case、,
        hicpp-exception-baseclass,
        hicpp-multiway-paths-covered,
        hicpp-no-assembler,
        misc-definitions-in-headers,
        misc-misleading-bidirectional,
        misc-misplaced-const,
        misc-new-delete-overloads,
        misc-non-copyable-objects,
        misc-static-assert,
        misc-throw-by-value-catch-by-reference,
        misc-unconventional-assign-operator,
        misc-uniqueptr-reset-release,
        modernize-avoid-bind,
        modernize-concat-nested-namespaces,
        modernize-deprecated-headers,
        modernize-deprecated-ios-base-aliases,
        modernize-loop-convert,
        modernize-make-shared,
        modernize-make-unique,
        modernize-pass-by-value,
        modernize-raw-string-literal,
        modernize-redundant-void-arg,
        modernize-replace-auto-ptr,
        modernize-replace-disallow-copy-and-assign-macro,
        modernize-replace-random-shuffle,
        modernize-return-braced-init-list,
        modernize-shrink-to-fit,
        modernize-unary-static-assert,
        modernize-use-auto,
        modernize-use-bool-literals,
        modernize-use-default-member-init,
        modernize-use-emplace,
        modernize-use-equals-default,
        modernize-use-equals-delete,
        modernize-use-nodiscard,
        modernize-use-noexcept,
        modernize-use-nullptr,
        modernize-use-override,
        modernize-use-transparent-functors,
        modernize-use-uncaught-exceptions,
        mpi-*,
        openmp-use-default-none,
        performance-faster-string-find,
        performance-for-range-copy,
        performance-implicit-conversion-in-loop,
        performance-inefficient-algorithm,
        performance-inefficient-string-concatenation,
        performance-inefficient-vector-operation,
        performance-move-const-arg,
        performance-move-constructor-init,
        performance-no-automatic-move,
        performance-no-int-to-ptr,
        performance-noexcept-move-constructor,
        performance-trivially-destructible,
        performance-type-promotion-in-math-fn,
        performance-unnecessary-copy-initialization,
        performance-unnecessary-value-param,
        portability-simd-intrinsics,
        readability-avoid-const-params-in-decls,
        readability-braces-around-statements,
        readability-const-return-type,
        readability-container-data-pointer,
        readability-container-size-empty,
        readability-convert-member-functions-to-static,
        readability-delete-null-pointer,
        readability-deleted-default,
        readability-inconsistent-declaration-parameter-name,
        readability-make-member-function-const,
        readability-misleading-indentation,
        readability-misplaced-array-index,
        readability-non-const-parameter,
        readability-qualified-auto,
        readability-redundant-access-specifiers,
        readability-redundant-control-flow,
        readability-redundant-declaration,
        readability-redundant-function-ptr-dereference,
        readability-redundant-member-init,
        readability-redundant-preprocessor,
        readability-redundant-smartptr-get,
        readability-redundant-string-cstr,
        readability-redundant-string-init,
        readability-simplify-boolean-expr,
        readability-simplify-subscript-expr,
        readability-static-accessed-through-instance,
        readability-static-definition-in-anonymous-namespace,
        readability-string-compare,
        readability-uniqueptr-delete-release,
        readability-use-anyofallof,
        bugprone-argument-comment,
        bugprone-infinite-loop,
        misc-unused-parameters]],
        "--completion-style=detailed",
        "--cross-file-rename=true",
        "--header-insertion=iwyu",
        "--pch-storage=memory",
        -- 启用这项时，补全函数时，将会给参数提供占位符，键入后按 Tab 可以切换到下一占位符
        "--function-arg-placeholders=true",
        "--log=verbose",
        "--ranking-model=decision_forest",
        -- 输入建议中，已包含头文件的项与还未包含头文件的项会以圆点加以区分
        "--header-insertion-decorators",
        "-j=12",
        "--pretty",
      }
    }
  end
})
