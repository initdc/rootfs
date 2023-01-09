# frozen_string_literal: true

require_relative "../debian"

module RootFS
  module Distro
    module Debian
      extend self

      def files_of(edition = "netinst", release = "11.6.0", build: "release", arch: "amd64")
        url = RootFS::Distro::Debian.url_of(edition, release, build: build, arch: arch)
        return if url.nil?

        if %w[docker slim].include?(edition)
          file = url.split("/").last.delete_suffix(".sha256")
          return { sha256sum: url, files: [file] }
        end

        keywords = if edition == "desktop"
                     [arch, ".iso"]
                   elsif edition == "cloud"
                     [arch, "generic-", ".tar.xz"]
                   else
                     [arch]
                   end
        ignores = %w[edu mac]

        resp = RootFS::HTTP.get(url)
        body = resp.body
        files = RootFS::Data.from_sha256sum(body, keywords, ignores)
        { sha256sum: url, files: files }
      end
    end
  end
end
