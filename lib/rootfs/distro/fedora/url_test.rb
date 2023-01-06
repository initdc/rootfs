# frozen_string_literal: true

require_relative "url"

class MyClass
  extend RootFS::Distro::Fedora
  include RootFS::Distro::Fedora
end

f = MyClass.new

p f.url_of
p f.url_of("alt")
p f.url_of("2nd")
p f.url_of("3rd")
