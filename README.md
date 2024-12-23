# hello-zig

[![.github/workflows/CI.yml](https://github.com/seletz/hello-zig/actions/workflows/CI.yml/badge.svg)](https://github.com/seletz/hello-zig/actions/workflows/CI.yml)

Some experiments in [zig](https://ziglang.org).  The main goal here is to get some graphics going and generally play around a bit.

## TODO

- [x] Get a `hello world` going
- [x] Get syntax highlighting and debugging to work
- [x] Get a basic triangle on the screen
- [ ] Get a animated triangle mesh going. Wireframes only.
- [ ] Build for other systems than macos
- [ ] Try to get a dynamic library built in zig, and use `dlopen()` to live-reload functions 

## Decisions made

- Zig people seem to use VSCode.  Well, ok then.
- I tried raylib-zig but could not get it to compile.  Switched to [sokol](https://github.com/floooh/sokol) and [sokol-zig](https://github.com/floooh/sokol-zig) bindings.

## Dependencies

### VSCode

>[!Note]
> I use `vscodium` and I'm a complete NOOB wrt VSCode.

I use these extensions:

- [Zig Language](https://open-vsx.org/vscode/item?itemName=ziglang.vscode-zig), which installs `zig` and `zls` (zig language server)
- The debugger task uses [CodeLLDB](https://open-vsx.org/vscode/item?itemName=vadimcn.vscode-lldb)
- [Shader language support](https://open-vsx.org/vscode/item?itemName=slevesque.shader)
- [GLSL Lint](https://open-vsx.org/vscode/item?itemName=dtoplak.vscode-glsllint) *could not get this running*

### sokol

- put `sokol-shdc` from [sokol-tools](https://github.com/floooh/sokol-tools/tree/master) somewhere in your path. I used the binaries from [sokol-tools-bin](https://github.com/floooh/sokol-tools-bin) and linked it to `~/.local/bin`