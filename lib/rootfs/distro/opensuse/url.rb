# frozen_string_literal: true

require_relative "../opensuse"

module RootFS
  module Distro
    module OpenSUSE
      extend self

      # https://github.com/openSUSE/MirrorCache/issues/338

      # https://download.opensuse.org/distribution/leap/15.5/live/?json&P=*Live*Media.iso.sha256
      # https://download.opensuse.org/distribution/leap/15.5/appliances/?json&P=*tar.xz.sha256

      # https://download.opensuse.org/distribution/leap-micro/5.3/product/iso/?json&P=*DVD*Build*.iso.sha256

      # https://download.opensuse.org/tumbleweed/iso/?json&P=*Live*Media.iso.sha256
      # https://download.opensuse.org/tumbleweed/appliances/?json&P=*tar.xz.sha256

      # https://download.opensuse.org/ports/aarch64/distribution/leap/15.4/live/?json&P=*Live*Media.iso.sha256
      # https://download.opensuse.org/ports/aarch64/distribution/leap/15.4/appliances/?json&P=*tar.xz.sha256

      # https://download.opensuse.org/ports/aarch64/tumbleweed/appliances/?json&P=*tar.xz.sha256
      # https://download.opensuse.org/ports/riscv/tumbleweed/images/?json&P=*tar.xz.sha256

      EDITION_URL = {
        leap: {
          desktop: {
            x86_64: "https://download.opensuse.org/distribution/leap/{version}/live/?json&P=*Live*Media.iso.sha256",
            aarch64: "https://download.opensuse.org/distribution/leap/{version}/live/?json&P=*Live*Media.iso.sha256"
          },
          server: "https://download.opensuse.org/distribution/leap/{version}/appliances/?json&P=*tar.xz.sha256"
        },
        leapmicro: {
          x86_64: "https://download.opensuse.org/distribution/leap-micro/{version}/product/iso/?json&P=*DVD*Build*.iso.sha256",
          aarch64: "https://download.opensuse.org/distribution/leap-micro/{version}/product/iso/?json&P=*DVD*Build*.iso.sha256"
        },
        tumbleweed: {
          desktop: {
            x86_64: "https://download.opensuse.org/tumbleweed/iso/?json&P=*Live*Media.iso.sha256",
            i686: "https://download.opensuse.org/tumbleweed/iso/?json&P=*Live*Media.iso.sha256"
          },
          microos: {
            x86_64: "https://download.opensuse.org/tumbleweed/iso/?json&P=*MicroOS*Media.iso.sha256",
            others: "https://download.opensuse.org/ports/{arch}/tumbleweed/iso/?json&P=*MicroOS*Media.iso.sha256"
          },
          server: {
            x86_64: "https://download.opensuse.org/tumbleweed/appliances/?json&P=*tar.xz.sha256",
            riscv: "https://download.opensuse.org/ports/{arch}/tumbleweed/images/?json&P=*tar.xz.sha256",
            others: "https://download.opensuse.org/ports/{arch}/tumbleweed/appliances/?json&P=*tar.xz.sha256"
          }
        }
      }.freeze

      def url_of(ver, arch = "x86_64", edi = "server")
        hash = RootFS::Distro::OpenSUSE.parse_version(ver)
        return unless hash

        branch = hash[:branch]
        version = hash[:version]

        hash = RootFS::Distro::OpenSUSE.parse_edition(edi)
        return unless hash

        edition = hash[:edition]

        hash = RootFS::Distro::OpenSUSE.parse_arch(arch)
        return unless hash

        arch = hash[:arch]

        url_tmpl = nil

        if branch == "leap"
          if edition == "server"
            url_tmpl = EDITION_URL[:leap][:server]
            url_tmpl.gsub("{version}", version) if url_tmpl
          else
            url_tmpl = EDITION_URL[:leap][edition.to_sym][arch.to_sym]
            url_tmpl.gsub("{version}", version) if url_tmpl
          end
        elsif branch == "leapmicro"
          url_tmpl = EDITION_URL[:leapmicro][arch.to_sym]
          url_tmpl.gsub("{version}", version) if url_tmpl
        elsif branch == "tumbleweed"
          if edition == "microos"
            key = arch
            key = "others" if arch != "x86_64"
            url_tmpl = EDITION_URL[:tumbleweed][:microos][key.to_sym]
            url_tmpl.gsub("{arch}", arch) if url_tmpl
          elsif edition == "server"
            key = arch
            key = "others" if arch != "x86_64" && arch != "riscv"
            url_tmpl = EDITION_URL[:tumbleweed][:server][key.to_sym]
            url_tmpl.gsub("{arch}", arch) if url_tmpl
          else
            url_tmpl = EDITION_URL[:tumbleweed][edition.to_sym][arch.to_sym]
            url_tmpl.gsub("{arch}", arch) if url_tmpl
          end
        end
      end
    end
  end
end
