# frozen_string_literal: true

require "libexec"
require_relative "../manifest"

module RootFS
  module Package
    module Apk
      extend RootFS::Manifest
      include RootFS::Manifest

      # https://docs.fedoraproject.org/en-US/fedora/latest/system-administrators-guide/RPM/
      def installed
        list = []
        Libexec.each_line("apk info") do |line|
          next if line.start_with?("WARNING: ")

          list.push(line.chomp)
        end
        list.sort
      end

      def generate_manifest(file = nil, install: false, show: true)
        re = /(?<pkg_ver>\S+) (?<arch>\S+) \{(?<pkg>\S+)\}/

        list = []
        Libexec.each_line("apk list -I") do |line|
          next if line.start_with?("WARNING: ")

          re.match(line.chomp) do |matchdata|
            pkg = matchdata[:pkg]
            pkg_ver = matchdata[:pkg_ver]
            pkg_name = pkg_ver.split("-")[0..-3].join("-")
            ver = pkg_ver.split("-")[-2..].join("-")

            if install
              list.push("#{pkg}\n")
            else
              list.push("#{pkg_name}\t#{ver}\n")
            end
          end
        end
        content = if install
                    list.uniq.sort.join
                  else
                    list.sort.join
                  end

        if file
          Libexec.run("echo -n > #{file} '#{content}'")
        else
          puts content if show
          list.uniq.sort.join if install
        end
      end

      def can_install(any)
        pkgs = any.instance_of?(Array) ? any : manifest_package(any)

        ignores = []
        Libexec.each_line("apk -s add #{pkgs.join(" ")}") do |line|
          err_suff = " (no such package):"
          if line.include?(err_suff)
            pkg = line.chomp.delete_suffix(err_suff).delete_prefix("  ")
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
