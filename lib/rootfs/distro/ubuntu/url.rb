# frozen_string_literal: true

require_relative "edition"
require_relative "arch"

module RootFS
  module Distro
    module Ubuntu
      extend self

      # http://releases.ubuntu.com/
      # http://cdimage.ubuntu.com/
      # https://cloud-images.ubuntu.com/

      EDITION_URL = {
        desktop: {
          release: {
            amd64: "http://releases.ubuntu.com/{version}/SHA256SUMS",
            others: "http://cdimage.ubuntu.com/releases/{version}/release/SHA256SUMS"
          },
          daily: {
            amd64: "http://cdimage.ubuntu.com/{codename}/daily-live/current/SHA256SUMS",
            others: "http://cdimage.ubuntu.com/{codename}/daily-preinstalled/current/SHA256SUMS"
          }
        },
        server: {
          release: {
            amd64: "http://releases.ubuntu.com/{version}/SHA256SUMS",
            others: "http://cdimage.ubuntu.com/releases/{version}/release/SHA256SUMS"
          },
          daily: {
            amd64: "http://cdimage.ubuntu.com/ubuntu-server/{codename}/daily-live/current/SHA256SUMS",
            others: "http://cdimage.ubuntu.com/ubuntu-server/{codename}/daily-preinstalled/current/SHA256SUMS"
          }
        },
        base: {
          release: "http://cdimage.ubuntu.com/ubuntu-base/releases/{version}/release/SHA256SUMS",
          daily: "http://cdimage.ubuntu.com/ubuntu-base/{codename}/daily/current/SHA256SUMS"
        },
        cloud: {
          release: "https://cloud-images.ubuntu.com/releases/{version}/release/SHA256SUMS",
          daily: "https://cloud-images.ubuntu.com/{codename}/current/SHA256SUMS"
        },
        minimal: {
          release: "https://cloud-images.ubuntu.com/minimal/releases/{codename}/release/SHA256SUMS",
          daily: "https://cloud-images.ubuntu.com/minimal/daily/{codename}/current/SHA256SUMS"
        }
      }.freeze

      def url_of(edi, rel, daily = false, arch: "amd64")
        hash = RootFS::Distro::Ubuntu.parse_edition(edi)
        return unless hash

        edition = hash[:edition]

        hash = RootFS::Distro::Ubuntu.parse_release(rel)
        return unless hash

        type = hash[:type]
        codename = hash[:codename]
        version = hash[:version]
        dev = hash[:dev]
        daily ||= type == "codename"

        hash = RootFS::Distro::Ubuntu.parse_arch(arch)
        return unless hash

        arch = hash[:arch]

        url_tmpl = if %w[desktop server].include?(edition)
                     if arch == "amd64"
                       !daily ? EDITION_URL[edition.to_sym][:release][:amd64] : EDITION_URL[edition.to_sym][:daily][:amd64]
                     else
                       !daily ? EDITION_URL[edition.to_sym][:release][:others] : EDITION_URL[edition.to_sym][:daily][:others]
                     end
                   else
                     !daily ? EDITION_URL[edition.to_sym][:release] : EDITION_URL[edition.to_sym][:daily]
                   end

        top_dir = url_tmpl.include?("cdimage.ubuntu.com") && dev && daily
        codename = "" if top_dir

        url_tmpl.gsub("{version}", version).gsub("{codename}", codename.to_s)
      end
    end
  end
end
