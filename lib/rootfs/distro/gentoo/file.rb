# frozen_string_literal: true

require_relative "../gentoo"

module RootFS
  module Distro
    module Gentoo
      extend self

      def files_of(*argv, **opts)
        arch = argv[0] || opts[:arch] || "amd64"
        feature = argv[1] || opts[:feature] || ["openrc"]

        url = RootFS::Distro::Gentoo.url_of(arch)
        return if url.nil?

        hash = Gentoo.parse_feature(feature)
        return unless hash

        feature = hash[:feature]

        resp = RootFS::HTTP.get(url)
        body = resp.body
        files = RootFS::Data.from_gentoo_txt(body, feature)
        { latest: url, files: files }
      end
    end
  end
end
