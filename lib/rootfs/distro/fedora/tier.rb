# frozen_string_literal: true

require_relative "../../parse"

module RootFS
  module Distro
    module Fedora
      extend self

      # https://dl.fedoraproject.org/pub/
      TIER = %w[
        fedora
        fedora-secondary
        alt
      ].freeze

      # https://dl.fedoraproject.org/pub/fedora/linux/releases/
      VERSION = %(
        rawhide
        test
        7
        8
        9
        10
        11
        12
        13
        14
        15
        16
        17
        18
        19
        20
        21
        22
        23
        24
        25
        26
        27
        28
        29
        30
        31
        32
        33
        34
        35
        36
        37
      )

      # https://dl.fedoraproject.org/pub/fedora/linux/development/rawhide/
      EDITION = %w[
        AtomicHost
        AtomicWorkstation
        Cloud
        Container
        Everything
        Kinoite
        Modular
        Server
        Silverblue
        Spins
        Workstation
      ].freeze

      # https://dl.fedoraproject.org/pub/fedora/imagelist-fedora
      DESKTOP = %w[
        MATE_Compiz
        Cinnamon
        KDE
        LXDE
        LXQt
        SoaS
        Xfce
        i3
      ].freeze

      def parse_tier(any = "fedora")
        any = "fedora" if any == "1st"
        any = "fedora-secondary" if any == "2nd"
        any = "alt" if any == "3rd"
        RootFS::Parse._str_in_arr(any, "Fedora", "tier", TIER)
      end

      def parse_version(any = "rawhide")
        any = any.to_s if any.instance_of?(0.class)
        RootFS::Parse._str_in_arr(any, "Fedora", "version", VERSION)
      end

      def parse_edition(any = "Container")
        RootFS::Parse._str_in_arr(any, "Fedora", "edition", EDITION)
      end

      def parse_desktop(any)
        RootFS::Parse._str_in_arr(any, "Fedora", "desktop", DESKTOP)
      end
    end
  end
end
