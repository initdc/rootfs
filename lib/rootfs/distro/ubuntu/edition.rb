# frozen_string_literal: true

require_relative "../../parse"

module RootFS
  module Distro
    module Ubuntu
      extend self

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

      def parse_edition(any)
        RootFS::Parse._str_in_arr(any, "Ubuntu", "edition", EDITION)
      end

      def parse_release(any)
        str = any.instance_of?(0.1.class) ? format("%.2f", any) : any.to_s
        sym = str.to_sym
        if CODENAME_VERSION.key?(sym)
          version = CODENAME_VERSION[sym]
          dev = DEV.key?(sym) ? true : false

          { type: "codename", codename: sym, version: version, dev: dev }
        elsif CODENAME_VERSION.value?(str)
          codename = CODENAME_VERSION.key(str)
          dev = DEV.value?(str) ? true : false

          { type: "version", codename: codename, version: str, dev: dev }
        else
          keys_values = CODENAME_VERSION.keys + CODENAME_VERSION.values
          puts "Valid Ubuntu release: #{keys_values}"
        end
      end
    end
  end
end
