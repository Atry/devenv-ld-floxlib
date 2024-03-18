This repository demonstrates how to fix https://github.com/cachix/devenv/issues/773 by using [ld-floxlib](https://github.com/flox/ld-floxlib)

By adding some [LD_AUDIT settings](https://github.com/Atry/devenv-ld-floxlib/blob/8d008b28a88817c39fadd0be5368b0d7d7b2534d/flake.nix#L30-L41), the following command will work without any error:

```
nix develop --impure
```
