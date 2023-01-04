# frozen_string_literal: true

require_relative "edition"

class MyClass
  extend RootFS::Distro::OpenSUSE
  include RootFS::Distro::OpenSUSE
end

o = MyClass.new

p o.parse_branch("leap")
p o.parse_edition("desktop")
p o.parse_desktop("GNOME")

p o.parse_version(15.4)
p o.parse_version("alpha")
p o.parse_version(5.3)
