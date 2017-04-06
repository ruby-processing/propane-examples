# propane-examples
Example Sketches for propane-2.3.0 see also [Example-Sketches][examples] for JRubyArt (many of with only need to be class wrapped to run with propane).

WIP to complete translation from JRubyArt to propane using [this conversion tool][conversion], and by replacing `Processing::Proxy` with `Propane::Proxy`, and unnest some classes as required.

See how to install [java libraries here][contributed]

To autorun many samples `cd` this directory and `rake` for others like pbox2d
`rake pbox2d` you get the idea (read the Rakefile). NB: not all samples ge autorun and where appropriate you need to install library or gem.

[conversion]:https://gist.github.com/monkstone/6f61ecf6c0f222d9b80250bd60a8c84f
[examples]:https://github.com/ruby-processing/JRubyArt-examples
[contributed]:https://ruby-processing.github.io/propane/contributed
