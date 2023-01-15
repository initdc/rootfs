# frozen_string_literal: true

require "libexec"

module RootFS
  module Package
    module Dpkg
      # https://manpages.ubuntu.com/manpages/jammy/man1/dpkg-query.1.html
      def installed
        list = []
        Libexec.each_line("dpkg-query -f '${binary:Package}\n' -W") do |line|
          list.push(line.chomp)
        end
        list
      end

      def installed_by_user
        list = []
        Libexec.each_line("apt-mark showmanual") do |line|
          list.push(line.chomp)
        end
        list
      end

      def generate_manifest(file = nil)
        if file
          Libexec.run("dpkg-query -f '${binary:Package}\t${Version}\n' -W > #{file}")
        else
          Libexec.run("dpkg-query -f '${binary:Package}\t${Version}\n' -W")
        end
      end

      def parse_manifest(file, &block)
        IO.readlines(file, &block)
      end

      def manifest_package(file)
        list = []
        IO.readlines(file).each do |line|
          pkg = line.include?("\t") ? line.split("\t")[0] : line.split(" ")[0]
          list.push(pkg)
        end
        list
      end

      def can_install(pkgs)
        ignores = []
        Libexec.each_line("apt-get install #{pkgs.join(" ")} 2>&1") do |line|
          err_pre = "E: Unable to locate package "
          if line.include?(err_pre)
            pkg = line.chomp.delete_prefix(err_pre)
            ignores.push(pkg)
          end
        end
        return pkgs if ignores.empty?

        pkgs -= ignores
        can_install(pkgs)
      end

      def can_from_file(file)
        pkgs = []
        IO.readlines(file).each do |line|
          pkgs.push(line.chomp)
        end
        can_install(pkgs)
      end
    end
  end
end
