# pastel-packages

The list of [Pastel](https://github.com/azrov/pastel) packages — what Packagist is for Composer, without a server: `pastel add` and `pastel search` read [`packages.toml`](packages.toml) from this repository.

```sh
pastel search             # all packages
pastel search serial
pastel add serial
```

## Adding your package

1. Your package is a Pastel library (`pastel new lib`) in a public git repository, with a `README.md`, tests, and at least one version tag (`v0.1.0`).
2. Open a pull request that adds it to `packages.toml`, in alphabetical order:

```toml
[your-package]
git = "https://github.com/you/pastel-your-package"
description = "What it does, in one line"
```

`path = "folder"` when the repository holds several packages.

The checks build the package and run its tests on Linux; a maintainer then looks at it and merges. Names are first come, first served; a package that is no longer kept up may be marked or removed.

## Rules

- The name says what it is (`serial`, `barcode`, `chart`); no `pastel-` in front.
- The code is open source (MIT, BSD, Apache, LGPL with static linking exception...).
- No code that does something the user would not expect (sending data away, mining...).

## Your own registry

A company can keep its own list of private packages in the same format:

```sh
export PASTEL_REGISTRY=https://git.my-company.com/pastel-packages
```
