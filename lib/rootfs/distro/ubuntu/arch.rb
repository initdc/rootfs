# frozen_string_literal: true

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
        err_msg = "Valid Ubuntu arch: #{ARCH}"

        puts err_msg unless any

        str = any.to_s
        puts err_msg if str.empty?

        return { arch: str } if ARCH.include?(str)

        puts err_msg
      end
    end
  end
end
