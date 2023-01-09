# frozen_string_literal: true

require_relative "../debian"

module RootFS
  module Distro
    module Debian
      extend self

      # https://cdimage.debian.org/cdimage/
      # https://doi-janky.infosiftr.net/job/tianon/job/debuerreotype/

      EDITION_URL = {
        netinst: {
          testing: {
            release: "https://cdimage.debian.org/cdimage/bookworm_di_alpha2/{arch}/iso-cd/SHA256SUMS",
            daily: "https://cdimage.debian.org/cdimage/daily-builds/daily/arch-latest/{arch}/iso-cd/SHA256SUMS",
            weekly: "https://cdimage.debian.org/cdimage/weekly-builds/{arch}/iso-cd/SHA256SUMS"
          },
          stable: {
            release: "https://cdimage.debian.org/cdimage/release/current/{arch}/iso-cd/SHA256SUMS"
          },
          archive: "https://cdimage.debian.org/cdimage/archive/{version}/{arch}/iso-cd/SHA256SUMS"
        },
        desktop: {
          testing: {
            weekly: "https://cdimage.debian.org/cdimage/weekly-live-builds/{arch}/iso-hybrid/SHA256SUMS"
          },
          stable: {
            release: "https://cdimage.debian.org/cdimage/release/current-live/{arch}/iso-hybrid/SHA256SUMS"
          },
          archive: "https://cdimage.debian.org/cdimage/archive/{version}-live/{arch}/iso-hybrid/SHA256SUMS"
        },
        cloud: {
          release: "https://cdimage.debian.org/cdimage/cloud/{codename}/latest/SHA512SUMS",
          daily: "https://cdimage.debian.org/cdimage/cloud/{codename}/daily/latest/SHA512SUMS"
        },
        docker: {
          daily: "https://doi-janky.infosiftr.net/job/tianon/job/debuerreotype/job/{arch}/lastSuccessfulBuild/artifact/{codename}/rootfs.tar.xz.sha256"
        },
        slim: {
          daily: "https://doi-janky.infosiftr.net/job/tianon/job/debuerreotype/job/{arch}/lastSuccessfulBuild/artifact/{codename}/slim/rootfs.tar.xz.sha256"
        }
      }.freeze

      def url_of(edi, rel, build: "release", arch: "amd64")
        hash = RootFS::Distro::Debian.parse_edition(edi)
        return unless hash

        edition = hash[:edition]

        hash = RootFS::Distro::Debian.parse_release(rel, build: build)
        return unless hash

        codename = hash[:codename]
        version = hash[:version]
        release = hash[:release]
        build = hash[:build]
        archive = hash[:archive]

        hash = RootFS::Distro::Debian.parse_arch(arch)
        return unless hash

        arch = hash[:arch]

        url_tmpl = if %w[netinst desktop].include?(edition)
                     if archive
                       EDITION_URL[edition.to_sym][:archive]
                     else
                       EDITION_URL[edition.to_sym][release][build.to_sym]
                     end
                   else
                     EDITION_URL[edition.to_sym][build.to_sym]
                   end

        return if url_tmpl.nil?

        url_tmpl.gsub("{version}", version).gsub("{arch}", arch).gsub("{codename}", codename.to_s)
      end
    end
  end
end
