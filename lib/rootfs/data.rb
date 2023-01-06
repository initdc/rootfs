# frozen_string_literal: true

require_relative "distro/ubuntu"

module RootFS
  module Data
    extend self

    def from_sha256sum(str, keywords, ignores = [])
      results = []
      lines = str.split("\n")
      lines.each do |line|
        arr = line.split(" ")
        file = arr[1]
        next unless file

        file = file.delete_prefix("*")

        all_matched = true

        ignores.each do |ignore|
          if file.include?(ignore)
            all_matched = false
            break
          end
        end
        next unless all_matched

        keywords.each do |keyword|
          unless file.include?(keyword)
            all_matched = false
            break
          end
        end
        results.push(file) if all_matched
      end
      results
    end

    def from_gentoo_txt(str, keywords)
      results = []
      lines = str.split("\n")
      lines.each do |line|
        next if line.start_with?("#")

        arr = line.split(" ")
        file = arr[0]
        next unless file

        all_matched = true

        keywords.each do |keyword|
          unless file.include?(keyword)
            all_matched = false
            break
          end
        end
        results.push(file) if all_matched
      end
      results
    end

    def from_fedora_txt(str, keywords)
      results = []
      lines = str.split("\n")
      lines.each do |line|
        file = line.delete_prefix(".")

        all_matched = true
        keywords.each do |keyword|
          unless file.include?(keyword)
            all_matched = false
            break
          end
        end
        results.push(file) if all_matched
      end
      results
    end

    def from_alpine_yaml(str)
      results = {}
      flavors = str.split("-\n")
      flavors.each do |flavor|
        next unless flavor.include?("flavor: alpine-minirootfs")

        lines = flavor.split("\n")
        lines.each do |line|
          line = line.delete_prefix("  ")
          arr = line.split(":")
          key = arr[0]
          value = arr[1]
          value = value.delete_prefix(" ") if value

          results[:version] = value if key == "version"
          results[:file] = value if key == "file"
          if key == "sha256"
            results[:sha256] = value
            break
          end
        end
        break
      end
      results
    end
  end
end
