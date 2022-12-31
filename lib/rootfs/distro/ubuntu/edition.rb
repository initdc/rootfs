# frozen_string_literal: true

module RootFS
  module Distro
    module Ubuntu
      # https://ubuntu.com/download

      # https://wiki.ubuntu.com/Releases
      # http://releases.ubuntu.com/
      # https://cloud-images.ubuntu.com/

      LTS = {
        jammy: "22.04",
        focal: "20.04",
        bionic: "18.04"
      }.freeze

      ESM = {
        xenial: "16.04",
        trusty: "14.04"
      }.freeze

      DEV = {
        lunar: "23.04",
        kinetic: "22.10"
      }.freeze

      CODENAME_VERSION = {}.merge(DEV, LTS, ESM).freeze

      def lts?(any)
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
