# frozen_string_literal: true

require_relative "tier"

class MyClass
  extend RootFS::Distro::Fedora
  include RootFS::Distro::Fedora
end

f = MyClass.new

p f.parse_tier
p f.parse_tier("alt")
p f.parse_tier("2nd")
p f.parse_tier("3rd")

p f.parse_version
p f.parse_version(37)

p f.parse_edition
p f.parse_edition("Spins")

p f.parse_desktop("KDE")
p f.parse_desktop("MATE")
