# frozen_string_literal: true

require "libexec"
require_relative "../manifest"

module RootFS
  module Package
    module Rpm
      extend RootFS::Manifest
      include RootFS::Manifest

      # rubocop:disable Style/FormatStringToken

      # https://docs.fedoraproject.org/en-US/fedora/latest/system-administrators-guide/RPM/
      def installed
        list = []
        Libexec.each_line("rpm -qa --qf '%{name}\n'") do |line|
          list.push(line.chomp)
        end
        list
      end

      def installed_by_user
        list = []
        Libexec.each_line("dnf repoquery --userinstalled") do |line|
          pkg = line.chomp.split(":")[0].split("-")[0..-2].join("-")
          list.push(pkg)
        end
        list
      end

      def generate_manifest(file = nil)
        if file
          Libexec.run("rpm -qa --qf '%{name}\t%{version}\n' | sort > #{file}")
        else
          Libexec.run("rpm -qa --qf '%{name}\t%{version}\n' | sort")
        end
      end

      def can_install(any)
        pkgs = any.instance_of?(Array) ? any : manifest_package(any)

        ignores = []
        Libexec.each_line("yum install #{pkgs.join(" ")}") do |line|
          puts line
          err_pre = "No match for argument: "
          if line.include?(err_pre)
            pkg = line.chomp.delete_prefix(err_pre)
            ignores.push(pkg)
          end
        end
        return pkgs if ignores.empty?

        pkgs -= ignores
        can_install(pkgs)
      end
    end
  end
end
