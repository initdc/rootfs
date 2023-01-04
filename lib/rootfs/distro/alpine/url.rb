# frozen_string_literal: true

require_relative "../alpine"

module RootFS
  module Distro
    module Alpine
      extend self

      # https://dl-cdn.alpinelinux.org/alpine/edge/releases/riscv64/

      URL_TMPL = "https://dl-cdn.alpinelinux.org/alpine/{version}/releases/{arch}/latest-releases.yaml"

      def url_of(version = "edge", arch = "x86_64")
        hash = Alpine.parse_version(version)
        return unless hash

        version = hash[:version]

        hash = Alpine.parse_arch(arch)
        return unless hash

        arch = hash[:arch]

        URL_TMPL.gsub("{version}", version).gsub("{arch}", arch)
      end
    end
  end
end
