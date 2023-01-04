# frozen_string_literal: true

require_relative "../gentoo"

module RootFS
  module Distro
    module Gentoo
      extend self

      # https://www.gentoo.org/downloads/
      # https://distfiles.gentoo.org/

      URL_TMPL = "https://bouncer.gentoo.org/fetch/root/all/releases/{arch}/autobuilds/latest-stage3.txt"

      def url_of(arch = "amd64")
        hash = Gentoo.parse_arch(arch)
        return unless hash

        arch = hash[:arch]
        URL_TMPL.gsub("{arch}", arch)
      end
    end
  end
end
