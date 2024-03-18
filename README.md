This repository demonstrates how to fix https://github.com/cachix/devenv/issues/773 by using [ld-floxlib](https://github.com/flox/ld-floxlib)

By adding some [LD_AUDIT settings](https://github.com/Atry/devenv-ld-floxlib/blob/23d49d4b2f7741141c86ef11b50b5d898fbdb519/flake.nix#L30-L39), the following command will work without any error:

```
nix develop --impure
```
