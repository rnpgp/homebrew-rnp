# Homebrew for rnp

This tap contains formulae relating to [rnp](https://github.com/riboseinc/rnp).


## Quick Install

Run this and it's all done.

``` sh
brew tap riboseinc/rnp
brew install --HEAD rnp
```

Or:

``` sh
brew install --HEAD riboseinc/rnp/rnp
```

## Install Tap

``` sh
brew tap riboseinc/rnp
```

## Install rnp

Currently it is a HEAD-only formula, i.e., you must install it using the `--HEAD` option:

``` sh
brew install --HEAD rnp
```

If the formula conflicts with one from `Homebrew/homebrew` or another
tap, you can run:

``` sh
brew install --HEAD riboseinc/rnp/rnp
```

You can also install via URL:

``` sh
brew install --HEAD https://raw.githubusercontent.com/riboseinc/homebrew-rnp/master/rnp.rb
```

## rnp HEAD requires botan HEAD

The `rnp` HEAD formula must be used with `botan` HEAD. See the
Troubleshooting section if you run into `botan` problems.

``` sh
brew unlink botan
brew install --HEAD botan
```

## Acceptable Formulae

You can read Homebrew’s Acceptable Formulae document [here](https://github.com/Homebrew/brew/blob/master/docs/Acceptable-Formulae.md).

## Troubleshooting

First, please run `brew update` and `brew doctor`.

Second, read the [Troubleshooting Checklist](https://github.com/Homebrew/brew/blob/master/docs/Troubleshooting.md#troubleshooting).

### Botan

If you got 'Botan build is missing a required feature' during the configure then you need to install botan using the --HEAD option:

``` sh
brew unlink botan
brew install --HEAD botan
```

**If you don’t read these it will take us far longer to help you with your problem.**

## More Documentation

`brew help`, `man brew` or check [our documentation](https://github.com/Homebrew/brew/tree/master/docs#readme).

## License

Code is under the [BSD 2 Clause license](https://github.com/Homebrew/brew/tree/master/LICENSE.txt).

