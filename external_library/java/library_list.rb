# frozen_string_literal: true

require 'open-uri'
require 'yaml'

my_list = []
# Source of libary data
VANILLA = 'http://download.processing.org/contribs'
# Struct to store library data
ALib = Struct.new(:name, :description, :url)
lib = nil

def extract(line, name)
  line.sub(name, '').strip
end

open(VANILLA) do |lib_list|
  loop do
    lin = lib_list.readline
    lib = ALib.new('dummy', 'dummy') if lin.start_with?('library')
    lib = nil if lin =~ /examples|mode|tool/
    lib.name = extract(lin, 'name=') if lib && lin.start_with?('name=')
    lib.url = extract(lin, 'download=') if lib && lin.start_with?('download=')
    lib.description = extract(lin, 'sentence=') if lib && lin.start_with?('sentence=')
    my_list << lib if lib && lin.start_with?('type=library') if lib

    break if lib_list.eof?
  end
end

File.write('libraries.yml', my_list.to_yaml)
