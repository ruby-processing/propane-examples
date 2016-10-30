Building the nn Library
===================

You need `jruby` to run the included `JRakefile`, you also need the `rake-compiler` gem.

This is the way jruby-extensions used to get build before [polyglot maven][polyglot] (_which is deemed a bit too complicated here_).

But you can start process with mri ruby, so cd this directory and rake to compile and run.

Or rake clean to remove library jar (useful if you want to re-compile) and its build.

[polyglot]:https://github.com/jruby/jruby-examples
