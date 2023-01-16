# frozen_string_literal: true

require_relative "apk"

class MyClass
  extend RootFS::Package::Apk
  include RootFS::Package::Apk
end

u = MyClass.new

# pp u.installed
# u.generate_manifest
# u.generate_manifest(install: true)
# u.generate_manifest(".rspec_status")

puts u.can_install(".rspec_status")
