# frozen_string_literal: true

require_relative "../fedora"

module RootFS
  module Distro
    module Fedora
      extend self

      # https://dl.fedoraproject.org/pub/fedora/imagelist-fedora
      # https://dl.fedoraproject.org/pub/fedora-secondary/imagelist-fedora-secondary
      # https://dl.fedoraproject.org/pub/alt/imagelist-alt

      URL_TMPL = "https://dl.fedoraproject.org/pub/{tier}/imagelist-{tier}"

      def url_of(tier = "fedora")
        hash = Fedora.parse_tier(tier)
        return unless tier

        tier = hash[:tier]
        URL_TMPL.gsub("{tier}", tier)
      end
    end
  end
end
