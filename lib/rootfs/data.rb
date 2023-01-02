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
  end
end
