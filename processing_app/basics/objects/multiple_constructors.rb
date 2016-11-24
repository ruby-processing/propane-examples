#!/usr/bin/env jruby
require 'propane'

class MultipleConstructors < Propane::App
# Multiple constructors in Processing / Java
#
# A class can have multiple constructors that assign the fields in different ways.
# Sometimes it's beneficial to specify every aspect of an object's data by assigning
# parameters to the fields, but other times it might be appropriate to define only
# one or a few.

# fjenett, 2010-03-13:
#
# Ruby constructors are called "initialize" no matter what the name of the class is.
#
# In Ruby you can not have multiple methods with the same name although they have different
# parameters. In fact the last definition of a method will override all previous ones.
# But there are two ways to define methods with variable parameters. One is to give the
# parameters a default value, the second is to use the catch-all asterix:


# def my_method1 ( a, b = "2" ) # can be called with one or two arguments
# end

# def my_method2 ( *args ) # can be called with any number of arguments, args is an array
# end


# Martin Prout, 2014-06-23:
# even more flexibility can be had by passing a hash see inheritance_two @todo update for ruby-2.1+


def setup
sketch_title 'Multiple Constructors'
background 204
no_loop
sp1 = Spot.new
sp2 = Spot.new width * 0.5, height * 0.5, 120
sp1.display self
sp2.display self
end

def draw

end

# vvv CLASS SPOT

class Spot
attr_accessor :x, :y, :radius
def initialize (x = 160, y = 180, r = 40) # can be called with 0 to 3 arguments
@x, @y, @radius = x, y, r
end

def display(app)
app.ellipse @x, @y, @radius*2, @radius*2
end
end

# ^^^ CLASS SPOT


def settings
size 640, 360
smooth(8)
end

end

MultipleConstructors.new