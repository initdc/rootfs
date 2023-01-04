# frozen_string_literal: true

require_relative "version"

class MyClass
  extend RootFS::Distro::Alpine
  include RootFS::Distro::Alpine
end

a = MyClass.new

p a.parse_version
p a.parse_version("3.17")
p a.parse_version(3.1)
p a.parse_version(3.10)
