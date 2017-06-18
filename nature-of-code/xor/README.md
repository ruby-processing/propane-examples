Building the xor (neural net) Library
===================

Here we do a [polyglot maven][polyglot] build. But you could do a manual build quite easily if you wished. If you have recent mvn installed all you need to do is

```bash
mvn package
```

See also how to build jruby [extensions][extensions] with polyglot maven

NB: It is important for the `library_loader` to put the `xor.jar` in `library/xor` directory if you do a manual bulid


[polyglot]:https://github.com/takari/polyglot-maven
[extensions]:https://github.com/jruby/jruby-examples
