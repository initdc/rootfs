# frozen_string_literal: true

module RootFS
  module Distro
    module Ubuntu
      # https://ubuntu.com/download

      # https://wiki.ubuntu.com/Releases
      # http://releases.ubuntu.com/
      # https://cloud-images.ubuntu.com/

      EDITION_RELEASE_URL = {
        Desktop: "http://cdimage.ubuntu.com/releases/",
        Server: "http://cdimage.ubuntu.com/releases/",
        Base: "http://cdimage.ubuntu.com/ubuntu-base/releases/",
        Cloud: "https://cloud-images.ubuntu.com/releases/",
        Minimal: "https://cloud-images.ubuntu.com/minimal/releases/"
      }.freeze

      EDITION_DAILY_URL = {
        Desktop: "http://cdimage.ubuntu.com/",
        Server: "http://cdimage.ubuntu.com/ubuntu-server/",
        Base: "http://cdimage.ubuntu.com/ubuntu-base/",
        Cloud: "https://cloud-images.ubuntu.com/",
        Minimal: "https://cloud-images.ubuntu.com/minimal/daily/"
      }.freeze
    end
  end
end
