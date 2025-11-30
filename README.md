# Dear ImGui Install
This is a Makefile and configure script to install [Dear ImGui](https://github.com/ocornut/imgui)
as a static library, which makes it easy to use via `pkg-config --cflags --libs imgui`, instead
of the usual way compiling it as part of an application.

This repository does not contain or submodule ImGui itself, because then it would be outdated all the time;
instead it is meant to work with any recent version of ImGui.

(only a few backends added so far, only tested on Linux)

## Installation
Clone this repository and change into its directory, then clone the ImGui repository
(any branch/commit you want) into an `imgui` subdirectory:
```shell
git clone --depth=1 -b master https://github.com/ocornut/imgui.git
```
Run the *configure* script. Set installation prefix, see `--help` for other options, e.g.
```shell
./configure --prefix=$HOME/local
```
Edit the generated `config.mk` if you want, then build and install (install may need `sudo`):
```shell
make
make install
```

## Notes
By default, each backend is enabled if the required library (`vulkan`, `glfw3`...) is found via pkg-config;
you may need to set the `PKG_CONFIG_PATH` environment variable. This autodetection can be overridden with e.g.
`--disable-sdl2`, see `--help`.
