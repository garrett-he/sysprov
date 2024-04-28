![logo](./images/sysprov-logo.png)

# sysprov

This repository contains a set of scripts for provisioning systems on POSIX
operating systems.

## Installation

`sysprov` can be installed by running the following command in your terminal:

```
curl -fsSL https://raw.githubusercontent.com/garrett-he/sysprov/main/remote-install.sh | bash
```

If you are installing through a mirror repository, you can set the environment
variable `SYSPROV_GIT_REMOTE`, then execute the above command:

```
SYSPROV_GIT_REMOTE=https://url/to/your/repo.git curl -fsSL https://url/to/your/repo/main/remote-install.sh | bash
```

Alternatively, you can clone this repository on your local machine and install
it manually:

```
git clone https://github.com/garrett-he/sysprov.git /tmp/sysprov
bash /tmp/sysprov
rm -rf /tmp/sysprov
```

## Configurations

The configuration files are located in directory `/config` directory and named
with platforms. You can edit these files and define the modules you want to
install.

Note:

1. `sysprov` will only load the configuration files of the corresponding
   platform, while others will be ignored.
2. Some modules have dependency relationships, so the order of definition is
   important

## Mirrors

If you want to use mirrors during the installation process, there are two
methods:

1. Pass option `-m MIRRORS`, this can only be used during local installation:

   ```
   ./install.sh -m "mirror1 mirror2"
   ```

2. By using the environment variable `SYSPROV_MIRRORS`, usually used during
   remote installation.

   ```
   SYSPROV_MIRRORS="mirror1 mirror2" curl -fsSL https://raw.githubusercontent.com/garrett-he/sysprov/main/remote-install.sh | bash
   ```

There are some pre-defined mirror bundles in directory `/mirrors`. You can use
them by any of the above methods.

Example, install sysprov with mirrors from tsinghua and ustc:

```
./install -m "tsinghua ustc"
```

Of course, you can also define mirror sources by yourself.

### All customizable mirror settings

#### common

* SYSPROV_MIRROR_DOTFILES_GIT_REMOTE
* SYSPROV_MIRROR_ZSH_OHMYZSH_GIT_REMOTE
* SYSPROV_MIRROR_ZSH_POWERLEVEL10K_GIT_REMOTE
* SYSPROV_MIRROR_ZSH_ZSH_AUTOSUGGESTIONS_GIT_REMOTE
* SYSPROV_MIRROR_ZSH_ZSH_SYNTAX_HIGHLIGHTING_GIT_REMOTE
* SYSPROV_MIRROR_PYPI_INDEX
* SYSPROV_MIRROR_PYENV_GIT_REMOTE
* SYSPROV_MIRROR_LUAENV_GIT_REMOTE
* SYSPROV_MIRROR_LUA_BUILD_GIT_REMOTE
* SYSPROV_MIRROR_NVM_GIT_REMOTE
* SYSPROV_MIRROR_PHPENV_GIT_REMOTE
* SYSPROV_MIRROR_PHP_BUILD_GIT_REMOTE
* SYSPROV_MIRROR_POWERLINE_FONTS_GIT_REMOTE

#### darwin only

* SYSPROV_MIRROR_HOMEBREW_INSTALL_GIT_REMOTE
* SYSPROV_MIRROR_HOMEBREW_API_DOMAIN
* SYSPROV_MIRROR_HOMEBREW_BOTTLE_DOMAIN
* SYSPROV_MIRROR_HOMEBREW_BREW_GIT_REMOTE
* SYSPROV_MIRROR_HOMEBREW_CORE_GIT_REMOTE

#### cygwin only

* SYSPROV_MIRROR_CYGWIN
* SYSPROV_MIRROR_APT_CYG_GIT_REMOTE

## License

Copyright (C) 2024 Garrett HE <garrett.he@outlook.com>

The BSD-3-Clause License, see [LICENSE](./LICENSE).
