<div align="center">

# asdf-gitwatch [![Build](https://github.com/maouw/asdf-gitwatch/actions/workflows/build.yml/badge.svg)](https://github.com/maouw/asdf-gitwatch/actions/workflows/build.yml) [![Lint](https://github.com/maouw/asdf-gitwatch/actions/workflows/lint.yml/badge.svg)](https://github.com/maouw/asdf-gitwatch/actions/workflows/lint.yml)

[gitwatch](https://github.com/gitwatch/gitwatch) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

**TODO: adapt this section**

- `bash`, `curl`, `tar`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add gitwatch
# or
asdf plugin add gitwatch https://github.com/maouw/asdf-gitwatch.git
```

gitwatch:

```shell
# Show all installable versions
asdf list-all gitwatch

# Install specific version
asdf install gitwatch latest

# Set a version globally (on your ~/.tool-versions file)
asdf global gitwatch latest

# Now gitwatch commands are available
gitwatch
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/maouw/asdf-gitwatch/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Altan Orhon](https://github.com/maouw/)
