# frozen_string_literal: true
# To Avoid the:-
# warning: ambiguous Java methods found, using color(float,float,float)
# we explicitly cast the array of color values `to_java(:float)`, as they are
# passed to the (overloaded) java/processing color method

class Palette
  include Propane::Proxy # needed to access 'color' and 'map1d'
  attr_reader :palette

  def initialize
    @palette = make_palette
  end

  def make_palette
    (0..256).map do |i|
      # Create the bands of colour for the palette (256 is the maximum colour))
      case i
      when 0..64 # Range of reds
        color(*[map1d(i, 0..64, 1..255), 0, 0].to_java(:float))
      when 64..128 # Range of orange
        color(*[255, map1d(i, 64..128, 1..255), 0].to_java(:float))
      when 128..172 # range of yellow
        color(*[255, 255, map1d(i, 128..172, 1..255)].to_java(:float))
      else
        color(*[180, 0, 0].to_java(:float))
      end
    end
  end

  def self.create_palette
    Palette.new.palette
  end
end
