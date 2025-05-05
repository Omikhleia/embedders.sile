# embedders.sile

[![License](https://img.shields.io/github/license/Omikhleia/embedders.sile?label=License)](LICENSE)
[![Luacheck](https://img.shields.io/github/actions/workflow/status/Omikhleia/embedders.sile/luacheck.yml?branch=main&label=Luacheck&logo=Lua)](https://github.com/Omikhleia/embedders.sile/actions?workflow=Luacheck)
[![Luarocks](https://img.shields.io/luarocks/v/Omikhleia/embedders.sile?label=Luarocks&logo=Lua)](https://luarocks.org/modules/Omikhleia/embedders.sile)

This module for the [SILE](https://github.com/sile-typesetter/sile) typesetting system provides "embedders" for text formats that can be converted to an image, e.g. the DOT graph language (Graphviz) or the LilyPond musical notation.

![](embedders.png)

## Installation

This module collection requires SILE v0.15.12.

Installation relies on the **luarocks** package manager.

To install the latest version, you may use the provided “rockspec”:

```
luarocks install embedders.sile
```

(Refer to the SILE manual for more detailed 3rd-party package installation information.)

## Usage

Examples are provided in the [examples](./examples) folder.

The in-code package documentation may also be useful.
A readable version of the documentation is included in the User Manual for the [resilient.sile](https://github.com/Omikhleia/resilient.sile) collection of classes and packages.

## License

The code and samples in this repository are released under the GNU General Public License v3.0, (c) 2023-2025 Omikhleia.
