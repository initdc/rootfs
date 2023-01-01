# frozen_string_literal: true

module RootFS
  module Distro
    module Ubuntu
      # https://ubuntu.com/download
      # https://wiki.ubuntu.com/Releases

      # http://releases.ubuntu.com/
      # http://cdimage.ubuntu.com/
      # https://cloud-images.ubuntu.com/

      EDITION = %w[
        desktop
        server
        base
        cloud
        minimal
      ].freeze

      DEV = {
        lunar: "23.04"
      }.freeze

      INTERIM = {
        kinetic: "22.10"
      }.freeze

      LTS = {
        jammy: "22.04",
        focal: "20.04",
        bionic: "18.04"
      }.freeze

      ESM = {
        xenial: "16.04",
        trusty: "14.04"
      }.freeze

      CODENAME_VERSION = {}.merge(DEV, INTERIM, LTS, ESM).freeze
    end
  end
end
