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

## Inspiration

List of sources for further inspiration

 * [GOW](https://github.com/bmatzelle/gow/wiki)
 * [homebrew](/mxcl/homebrew) + [brewdler](/andrew/brewdler)
 * [babushka](/benhoskings/babushka)
 * [chocolatey](http://chocolatey.org/)
