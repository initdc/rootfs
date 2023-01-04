# frozen_string_literal: true

require_relative "../../parse"

module RootFS
  module Distro
    module Alpine
      extend self

      # https://dl-cdn.alpinelinux.org/alpine/
      VERSION = %w[
        edge
        3.0
        3.1
        3.2
        3.3
        3.4
        3.5
        3.6
        3.7
        3.8
        3.9
        3.10
        3.11
        3.12
        3.13
        3.14
        3.15
        3.16
        3.17
      ].freeze

      def parse_version(any = "edge")
        RootFS::Parse._str_in_arr(any, "Alpine", "version", VERSION)
      end
    end
  end
end
