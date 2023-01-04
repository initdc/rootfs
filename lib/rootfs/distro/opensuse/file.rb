# frozen_string_literal: true

require_relative "../opensuse"

module RootFS
  module Distro
    module OpenSUSE
      extend self

      def files_of(ver, arch = "x86_64", edi = "server")
        keywords = [arch]

        url = RootFS::Distro::OpenSUSE.url_of(ver, arch, edi)
        return if url.nil?

        resp = RootFS::HTTP.get(url)
        body = resp.body
        files = RootFS::Data.from_suse_json(body, keywords)
        url = url.split("/")[0..-2].join("/") + "/"
        { url: url, files: files }
      end
    end
  end
end
