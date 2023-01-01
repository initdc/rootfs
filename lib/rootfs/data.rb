# frozen_string_literal: true

require_relative "distro/ubuntu"

module RootFS
  module Data
    def from_sha256sum(str, keywords)
      results = []
      lines = str.split("\n")
      lines.each do |line|
        arr = line.split(" ")
        file = arr[1].delete_prefix("*")

        all_matched = true
        keywords.each do |keyword|
          all_matched = false unless file.include?(keyword)
        end
        results.push(file) if all_matched
      end
      results
    end
  end
end
