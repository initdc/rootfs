# frozen_string_literal: true

require_relative "rpm"

class MyClass
  extend RootFS::Package::Rpm
  include RootFS::Package::Rpm
end

u = MyClass.new

# pp u.installed
# u.generate_manifest
# u.generate_manifest(".rspec_status")
# puts u.installed_by_user

puts u.can_install(".rspec_status")
