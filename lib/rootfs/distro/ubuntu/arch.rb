# frozen_string_literal: true

module RootFS
  module Distro
    module Ubuntu
      ARCH = %w[
        amd64
        arm64
        armhf
        pp64el
        riscv64
        s390x
      ].freeze
    end
  end
end
