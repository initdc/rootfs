# frozen_string_literal: true

require_relative "../../parse"

module RootFS
  module Distro
    module OpenSUSE
      extend self

      # https://get.opensuse.org/
      # https://get.opensuse.org/desktop/
      # https://get.opensuse.org/server/
      # https://get.opensuse.org/leap/15.5/
      # https://get.opensuse.org/leapmicro/5.3/
      # https://get.opensuse.org/microos/

      BRANCH = %w[
        leap
        leapmicro
        tumbleweed
      ].freeze

      BRANCH_EDITION = {
        leap: %w[
          desktop
          server
        ],
        tumbleweed: %w[
          desktop
          server
          microos
        ]
      }.freeze

      EDITION = BRANCH_EDITION.values.flatten.uniq.freeze

      DESKTOP = %w[
        GNOME
        KDE
        XFCE
        LXQT
        E20
        JeOS
        X11
      ].freeze

      BRANCH_VERSION = {
        leap: %w[
          15.0
          15.1
          15.2
          15.3
          15.4
          15.5
          alpha
          42.3
        ],
        leapmicro: %w[
          5.2
          5.3
        ],
        tumbleweed: %w[
          rolling
        ]
      }.freeze

      def parse_branch(any = "leap")
        RootFS::Parse._str_in_arr(any, "openSUSE", "branch", BRANCH)
      end

      def parse_edition(any)
        RootFS::Parse._str_in_arr(any, "openSUSE", "edition", EDITION)
      end

      def parse_desktop(any)
        RootFS::Parse._str_in_arr(any, "openSUSE", "desktop", DESKTOP)
      end

      def parse_version(any)
        any = format("%.1f", any) if any.instance_of?(0.1.class)
        values_leap = BRANCH_VERSION[:leap]
        values_leapmicro = BRANCH_VERSION[:leapmicro]
        values_tumbleweed = BRANCH_VERSION[:tumbleweed]

        if any == "alpha"
          index = values_leap.index("alpha")
          any = values_leap[index - 1]
        end

        if values_leap.include?(any)
          { branch: "leap", version: any }
        elsif values_leapmicro.include?(any)
          { branch: "leapmicro", version: any }
        elsif values_tumbleweed.include?(any)
          { branch: "tumbleweed", version: any }
        else
          values = values_leap + values_leapmicro + values_tumbleweed
          puts "Valid openSUSE version: #{values}"
        end
      end
    end
  end
end
