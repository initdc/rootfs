# frozen_string_literal: true

require_relative "../fedora"

module RootFS
  module Distro
    module Fedora
      extend self

      def files_of(*argv, **opts)
        tier = argv[0] || opts[:tier] || "fedora"
        version = argv[1] || opts[:version] || "rawhide"
        arch = argv[2] || opts[:arch] || "x86_64"
        edition = argv[3] || opts[:edition] || "Container"
        desktop = argv[4] || opts[:desktop]

        url = RootFS::Distro::Fedora.url_of(tier)
        return if url.nil?

        hash = Fedora.parse_version(version)
        return unless hash

        version = hash[:version]

        hash = Fedora.parse_arch(arch)
        return unless hash

        arch = hash[:arch]

        if edition
          hash = Fedora.parse_edition(edition)
          return unless hash

          edition = hash[:edition]
        end

        if desktop
          hash = Fedora.parse_desktop(desktop)
          return unless hash

          desktop = hash[:desktop]
        end

        keywords = []
        [version, edition, arch, desktop].each do |any|
          keywords.push(any) if any
        end

        resp = RootFS::HTTP.get(url)
        body = resp.body
        files = RootFS::Data.from_fedora_txt(body, keywords)
        { imagelist: url, files: files }
      end
    end
  end
end
