# frozen_string_literal: true

module RootFS
  module Distro
    module Ubuntu
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
    end
  end
end
