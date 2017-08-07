# propane-examples
Example Sketches for propane-2.3.2+ features updated control_panel library (replacing `c.title = 'PaneTitle'` with `c.title('PaneTitle')`) also enable use of `block` with `button's`.
See also [Example-Sketches][examples] for JRubyArt (many of with only need to be class wrapped to run with propane).

WIP to complete translation from JRubyArt to propane using [this conversion tool][conversion], and by replacing `Processing::Proxy` with `Propane::Proxy`, and unnest some classes as required.

See how to install [java libraries here][contributed]

To auto-run many samples `cd` this directory and `rake` for others like pbox2d
`rake pbox2d` you get the idea (read the Rakefile). NB: not all samples get auto-run, and where appropriate you need to install library or gem.

### Partial Catalogue (for the lazy)

1. [Basic][]

    1. [structure][]
    2. [objects][]
    3. [arrays][]
    4. [input][]
    5. [shape][]
    6. [image][]
    7. [control][]

2. [Topics][]

    1. [shaders][]
    2. [lsystems][]
    3. [advanced data][]

3. [Libraries][]
    1. [fastmath][]
    2. [vecmath][]
    3. [control-panel][]
    4. [video][]
    5. [glvideo][]
    6. [library proxy][]

4. Gems
   1. [PBox2D][pbox2d]
   2. [Geomerative][geomerative]
   3. [Toxiclibs][toxiclibs]
   4. [Wordcram][wordcram]
   5. [Sunflow raytracing][joons]

5. Java Libraries
   1. [Hype-processing][hype]
   2. [Hemesh][hemesh]
6. Others
   1. [WOVNS patterns][wovns]

### User contributions are most welcome
[Contributions][] add your [own][]

[wovns]:https://github.com/ruby-processing/propane-examples/tree/master/examples/WOVNS
[Learning Processing with Ruby]:https://github.com/ruby-processing/learning-processing-with-ruby
[Nature of Code Examples in ruby]:https://github.com/ruby-processing/The-Nature-of-Code-for-propane
[Contributions]:https://github.com/ruby-processing/propane-examples/tree/master/contributed
[own]:https://github.com/ruby-processing/propane-examples/blob/master/CONTRIBUTING.md
[Basic]:https://github.com/ruby-processing/propane-examples/tree/master/processing_app/basics
[structure]:https://github.com/ruby-processing/propane-examples/tree/master/processing_app/basics/structure
[objects]:https://github.com/ruby-processing/propane-examples/tree/master/processing_app/basics/objects
[arrays]:https://github.com/ruby-processing/propane-examples/tree/master/processing_app/basics/arrays
[control]:https://github.com/ruby-processing/propane-examples/tree/master/processing_app/basics/control
[shape]:https://github.com/ruby-processing/propane-examples/tree/master/processing_app/basics/shape
[input]:https://github.com/ruby-processing/propane-examples/tree/master/processing_app/basics/input
[image]:https://github.com/ruby-processing/propane-examples/tree/master/processing_app/basics/image
[Topics]:https://github.com/ruby-processing/propane-examples/tree/master/processing_app/topics
[lsystems]:https://github.com/ruby-processing/propane-examples/tree/master/processing_app/topics/lsystems
[advanced data]:https://github.com/ruby-processing/propane-examples/tree/master/processing_app/topics/advanced_data
[shaders]:https://github.com/ruby-processing/propane-examples/tree/master/processing_app/topics/shaders
[Libraries]:https://github.com/ruby-processing/propane-examples/tree/master/processing_app/library
[fastmath]:https://github.com/ruby-processing/propane-examples/tree/master/processing_app/library/fastmath
[glvideo]:https://github.com/ruby-processing/propane-examples/tree/master/processing_app/library/glvideo
[vecmath]:https://github.com/ruby-processing/propane-examples/tree/master/processing_app/library/vecmath
[video]:https://github.com/ruby-processing/propane-examples/tree/master/processing_app/library/video
[control-panel]:https://github.com/ruby-processing/propane-examples/tree/master/contributed/jwishy.rb
[PBox2D]:https://github.com/ruby-processing/propane-examples/tree/master/external_library/ruby_gem/jbox2d
[hype]:https://github.com/ruby-processing/propane-examples/tree/master/external_library/java/hype
[hemesh]:https://github.com/ruby-processing/propane-examples/tree/master/external_library/java/hemesh
[joons]:https://github.com/ruby-processing/propane-examples/tree/master/external_library/gem/joonsrenderer
[geomerative]:https://github.com/ruby-processing/propane-examples/tree/master/external_library/gem/geomerative
[toxiclibs]:https://github.com/ruby-processing/propane-examples/tree/master/external_library/gem/toxiclibs
[wordcram]:https://github.com/ruby-processing/propane-examples/tree/master/external_library/gem/ruby_wordcram
[propane]:https://ruby-processing.github.io/propane/

[conversion]:https://gist.github.com/monkstone/6f61ecf6c0f222d9b80250bd60a8c84f
[examples]:https://github.com/JRubyArt-examples/propane-examples
[contributed]:https://ruby-processing.github.io/propane/contributed

[library_proxy]:https://github.com/ruby-processing/propane-examples/tree/master/processing_app/library/library_proxy
