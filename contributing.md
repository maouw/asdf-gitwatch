# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

# TODO: adapt this
asdf plugin test gitwatch https://github.com/maouw/asdf-gitwatch.git "gitwatch"
```

Tests are automatically run in GitHub Actions on push and PR.
