# frozen_string_literal: true

module RootFS
  module Distro
    module Ubuntu
      # https://ubuntu.com/download

      # https://wiki.ubuntu.com/Releases
      # https://cloud-images.ubuntu.com/
      CODENAME_VERSION = {
        lunar: "23.04",
        kinetic: "22.10",
        jammy: "22.04",
        focal: "20.04",
        bionic: "18.04",
        xenial: "16.04",
        trusty: "14.04"
      }

      LTS = {
        jammy: "22.04",
        focal: "20.04",
        bionic: "18.04",
        xenial: "16.04",
        trusty: "14.04"
      }

      EDITION_RELEASE_URL = {
        Desktop: "http://cdimage.ubuntu.com/releases/",
        Server: "http://cdimage.ubuntu.com/releases/",
        Base: "http://cdimage.ubuntu.com/ubuntu-base/releases/",
        Cloud: "https://cloud-images.ubuntu.com/releases/",
        Minimal: "https://cloud-images.ubuntu.com/minimal/releases/"
      }

      EDITION_DAILY_URL = {
        Desktop: "http://cdimage.ubuntu.com/",
        Server: "http://cdimage.ubuntu.com/ubuntu-server/",
        Base: "http://cdimage.ubuntu.com/ubuntu-base/",
        Cloud: "https://cloud-images.ubuntu.com/",
        Minimal: "https://cloud-images.ubuntu.com/minimal/daily/"
      }

      def is_lts?(any)
        str = any.to_s
        LTS.each do |code, ver|
          return true if str == code.to_s
          return true if str.start_with?(ver)
        end
        false
      end
    end
  end
end
