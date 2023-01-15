# frozen_string_literal: true

require_relative "dpkg"

class MyClass
  extend RootFS::Package::Dpkg
  include RootFS::Package::Dpkg
end

u = MyClass.new

# pp u.installed
# u.generate_manifest
# u.generate_manifest(".rspec_status")
# u.parse_manifest(".rspec_status").each do |line|
#   puts line.split("\t").first
# end
# puts u.manifest_package(".rspec_status") - u.installed_by_user

# raspi_server_pkgs = u.manifest_package("manifest/rel/ubuntu-22.04.1-preinstalled-server-arm64+raspi.manifest")
# raspi_desktop_pkgs = u.manifest_package("manifest/rel/ubuntu-22.04.1-preinstalled-desktop-arm64+raspi.manifest")

# raspi_desktop = raspi_desktop_pkgs - raspi_server_pkgs
# puts raspi_desktop
# puts server_pkgs - desktop_pkgs

# comm_desktop = raspi_desktop.filter do |pkg|
#   pkg != "pi-bluetooth" &&
#     !pkg.include?("raspi") &&
#     !pkg.include?("oem") &&
#     !pkg.include?("rpi")
# end
# puts comm_desktop

base_pkg = u.manifest_package("manifest/jammy-base-arm64.manifest")
live_server_pkgs = u.manifest_package("manifest/jammy-live-server-arm64.manifest")
live_desktop_pkgs = u.manifest_package("manifest/jammy-desktop-arm64.manifest")

server = live_server_pkgs - base_pkg
desktop = live_desktop_pkgs - base_pkg

# puts server
# puts desktop

puts u.can_install(desktop)
# puts u.can_from_file("install.txt")
