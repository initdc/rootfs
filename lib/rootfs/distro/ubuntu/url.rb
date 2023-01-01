# frozen_string_literal: true

require_relative "edition"

module RootFS
  module Distro
    module Ubuntu
      extend self
      # http://releases.ubuntu.com/
      # http://cdimage.ubuntu.com/
      # https://cloud-images.ubuntu.com/

      EDITION_URL = {
        desktop: {
          release: "http://cdimage.ubuntu.com/releases/{version}/release/SHA256SUMS",
          daily: "http://cdimage.ubuntu.com/{codename}/daily-preinstalled/current/SHA256SUMS"
        },
        server: {
          release: "http://cdimage.ubuntu.com/releases/{version}/release/SHA256SUMS",
          daily: "http://cdimage.ubuntu.com/ubuntu-server/{codename}/daily-preinstalled/current/SHA256SUMS"
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

      def url_of(edi, rel, daily = false)
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

        url_tmpl = !daily ? EDITION_URL[edition.to_sym][:release] : EDITION_URL[edition.to_sym][:daily]
        top_dir = url_tmpl.start_with?("http://cdimage.ubuntu.com") && dev && daily
        codename = "" if top_dir

        url_tmpl.gsub("{version}", version).gsub("{codename}", codename.to_s)
      end
    end
  end
end
