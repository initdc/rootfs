# frozen_string_literal: true

require_relative "../alpine"

module RootFS
  module Distro
    module Alpine
      extend self

      def files_of(*argv, **opts)
        version = argv[0] || opts[:version] || "edge"
        arch = argv[1] || opts[:arch] || "x86_64"

        url = RootFS::Distro::Alpine.url_of(version, arch)
        return if url.nil?

        resp = RootFS::HTTP.get(url)
        return unless resp.success?

        body = resp.body
        files = RootFS::Data.from_alpine_yaml(body)

        files[:yaml] = url
        files
      end
    end
  end
end
