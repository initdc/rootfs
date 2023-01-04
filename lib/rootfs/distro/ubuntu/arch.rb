# frozen_string_literal: true

require_relative "../../parse"

module RootFS
  module Distro
    module Ubuntu
      extend self

      ARCH = %w[
        amd64
        arm64
        armhf
        pp64el
        riscv64
        s390x
      ].freeze

      def parse_arch(any)
        RootFS::Parse._str_in_arr(any, "Ubuntu", "arch", ARCH)
      end
    end
  end
end
