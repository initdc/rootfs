# frozen_string_literal: true

require_relative "../../parse"

module RootFS
  module Distro
    module Debian
      extend self

      # https://www.debian.org/releases/
      # https://wiki.debian.org/DebianReleases
      # https://wiki.debian.org/LTS
      # https://www.debian.org/doc/manuals/debian-faq/ftparchives#sourceforcodenames

      CODENAME_VERSION = {
        sid: "13",
        bookworm: "12",
        bullseye: "11",
        buster: "10",
        stretch: "9",
        jessie: "8"
      }.freeze

      RELEASE_VERSION = {
        unstable: "13",
        testing: "12",
        stable: "11",
        oldstable: "10",
        oldoldstable: "9"
      }.freeze

      CURRENT_VERSION = "11.6.0"

      REGULAR_BUILD = %w[
        release
        daily
        weekly
      ].freeze

      EDITION = %w[
        netinst
        desktop
        cloud
        docker
        slim
      ].freeze

      # https://cdimage.debian.org/debian-cd/current-live/amd64/iso-hybrid/
      DESKTOP = %w[
        cinnamon
        gnome
        kde
        lxde
        lxqt
        mate
        standard
        xfce
      ].freeze

      def archive?(semver)
        sem_arr = _semver_to_a(semver)
        curr_arr = _semver_to_a(CURRENT_VERSION)
        _less_than(sem_arr, curr_arr)
      end

      def parse_edition(any)
        RootFS::Parse._str_in_arr(any, "Debian", "edition", EDITION)
      end

      def parse_build(any)
        RootFS::Parse._str_in_arr(any, "Debian", "build", REGULAR_BUILD)
      end

      def parse_desktop(any)
        RootFS::Parse._str_in_arr(any, "Debian", "desktop", DESKTOP)
      end

      def parse_release(any, build: "release")
        hash = parse_build(build)
        return unless hash

        build = hash[:build]
        str = any.to_s
        sym = str.to_sym

        if REGULAR_BUILD.include?(str)
          testing_version = RELEASE_VERSION[:testing]
          testing_codename = CODENAME_VERSION.key(testing_version)
          { codename: testing_codename, version: testing_version,
            release: :testing, build: any, archive: false }
        elsif CODENAME_VERSION.key?(sym)
          version = CODENAME_VERSION[sym]
          release = RELEASE_VERSION.key(version)
          archive = archive?(version)

          { codename: sym, version: version,
            release: release, build: build, archive: archive }
        elsif RELEASE_VERSION.key?(sym)
          version = RELEASE_VERSION[sym]
          codename = CODENAME_VERSION.key(version)
          archive = archive?(version)

          { codename: codename, version: version,
            release: sym, build: build, archive: archive }
        else
          codename = nil
          version = nil

          version_valid = false
          CODENAME_VERSION.each do |code, ver|
            next unless str.start_with?(ver)

            version_valid = true
            codename = code
            version = ver
            break
          end

          if version_valid
            release = RELEASE_VERSION.key(version)
            archive = archive?(str)

            { codename: codename, version: str,
              release: release, build: build, archive: archive }
          else
            keys_values = CODENAME_VERSION.keys + CODENAME_VERSION.values + RELEASE_VERSION.keys
            puts "Valid Debian release: #{keys_values}"
          end
        end
      end

      private

      def _semver_to_a(str)
        str_arr = str.split(".")
        if str_arr.size < 3
          (3 - str_arr.size).times do
            str_arr.push(0)
          end
        end
        str_arr
      end

      # https://tldp.org/LDP/abs/html/comparison-ops.html
      def _less_than(arr1, arr2)
        num1 = arr1.shift.to_i
        num2 = arr2.shift.to_i

        if num1 < num2
          true
        elsif num1 > num2
          false
        elsif arr1.empty? && !arr2.empty?
          true
        elsif !arr1.empty? && arr2.empty?
          false
        elsif arr1.empty? && arr2.empty?
          false
        else
          _less_than(arr1, arr2)
        end
      end
    end
  end
end
