# WinUtils

A collection of useful windows utilities. Motivation behind this gem: I like bundler and how it's easy to manage dependencies with it, I want something similar for windows utilities. What utilities I talk about? For example:
 * to compile native gems **DevKit** is required;
 * to use `:git` option in Bundler **msysgit** is required;
 * to compile [libv8](/cowboyd/libv8) **python** and **svn** are required;
 * and so on.

I don't want to set up manually python or something like this on every machine where I need to install native gems.
Simplest solution which I came up is just wrap those utilities as gems. That is not the most elegant solution. I'm looking forward to implement solution to manage non-ruby dependencies. Something like [homebrew](/mxcl/homebrew) + [brewdler](/andrew/brewdler) or [babushka](/benhoskings/babushka).

If utilities is distributed through the gem mechanism, we can ensure that everybody have the same "environment". For example, older version of DevKit doesn't contatin `which` and instalation of rugged [produced an error](https://github.com/libgit2/rugged/issues/43#issuecomment-6516907).

This gem doesn't contain utilities itself, it's just "umbrella" gem for gems with real utilities. All utilities packs are placed in separte gems with name like `winutils-#{package name}`.

## Solution

### Wrapper
We have following options:
 * Use rubygems `executables` option. Fits only for standalone "portable" executables. If executable depends on external resources (like `git`), this will fail.
 * Implement ruby wrapper for executable. This executable will be exposed throught `executables` option. It will call original executable in subprocess with changed environmental variable `PATH` (added vendor folder). All input (`arguments`) and output (`stdin`, `stdout`, `exitstatus`) will be proxified. Cons of this solution - every executable requires wrapper. It's possible to automate generation of those wrappers. This solution will fit for standalone executable, like `git` or `python`
 * Use proxy executable, like `bundle exec command`. It will execute command in subprocess with right environment (`PATH`) seted and pass input and output.
 * Command which will set up environment.
   * Problem here - you can't change environment of current process (i.e. console) from child process (i.e. ruby script). It is possible to print out required changes of environment, so that parent process can apply them. To apply those changes we need to control parent process, it can be done with shell script (bat). But bat-files can't be exposed as gem executables, beacuse every gem executable get it's bat-wrapper. And to execute one bat from another it's requires special syntax (`call`). TODO: report this bug to rubygems.
   * Additionally check of current environment required, to be able to call script more than one time.
   * One more variant generate bat-file in project root. And use this generated script for environment setup.
   * [gem-exefy](/bosko/gem-exefy) RubyGems plugin for replacing Windows batch files used in Gems with executables with same name.

### Packaging
We have following options:
 * Pack executables inside rubygem
   * Bigger size of gems
   * To update executable you will need update gem every time
 * Download executables when installing rubygem
   * In case of failing external servers users will be unable to install gems
   * Installations of existing gems will stop work in case of changing of download path

Ideas:
 * Use reciepes like in [rubyinstaller](/oneclick/rubyinstaller), to download and unpack executables. Those reciepces can be used as prototype to the future solution (like `babushka`).
 * Version of the gem is the same as the version of the packed executable plus one more number, like in [libv8](/cowboyd/libv8/blob/master/lib/libv8/version.rb#L2)
 * Pack gems as native gems, to specify targeted OS and architecture

## Ruby gems which relies on external executables
### Examples
 * [grit](/mojombo/grit)
 * [mini_magick](/probablycorey/mini_magick)
 * [optipng](/martinkozak/optipng)
 * [jpegtran](/martinkozak/jpegtran)

### Drop-in solution
Maybe it will be good idea to modify gems dependent on external executables, so they check if companion winutils gem available. And if it's available it will use direct path to executable reported by companion gem.

### Spawn
There are plenty ways to spawn process in ruby. One of the best way to do it on *nix system is using [posix-spawn](/rtomayko/posix-spawn). Currently posix-spawn doesn't support Windows see [issue](/rtomayko/posix-spawn/pull/30)

## Inspiration

List of sources for further inspiration

 * [GOW](/bmatzelle/gow/wiki)
 * [homebrew](/mxcl/homebrew) + [brewdler](/andrew/brewdler)
 * [babushka](/benhoskings/babushka)
 * [chocolatey](http://chocolatey.org/)
