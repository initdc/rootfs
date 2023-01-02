# frozen_string_literal: true

require_relative "../../http"
require_relative "../../data"

module RootFS
  module Distro
    module Ubuntu
      extend self

      # [   ] SHA256SUMS                                             2022-12-14 02:49  5.6K  Current Released Image
      # [   ] SHA256SUMS.gpg                                         2022-12-14 02:49  836   Current Released Image

      # [   ]	ubuntu-22.10-preinstalled-desktop-arm64+raspi.img.xz	2022-10-18 15:06	2.0G	Preinstalled desktop image for Raspberry Pi Generic (64-bit ARM) computers (preinstalled SD Card image)
      # [   ]	ubuntu-22.10-preinstalled-desktop-arm64+raspi.img.xz.zsync	2022-10-20 16:12	4.0M	Preinstalled desktop image for Raspberry Pi Generic (64-bit ARM) computers (preinstalled SD Card image)
      # [TXT]	ubuntu-22.10-preinstalled-desktop-arm64+raspi.manifest	2022-10-18 15:06	46K	Preinstalled desktop image for Raspberry Pi Generic (64-bit ARM) computers (contents of live filesystem)

      # [   ]	ubuntu-22.10-preinstalled-server-arm64+raspi.img.xz	2022-10-19 08:32	1.0G	Preinstalled server image for Raspberry Pi Generic (64-bit ARM) computers (preinstalled SD Card image)
      # [   ]	ubuntu-22.10-preinstalled-server-arm64+raspi.img.xz.zsync	2022-10-20 16:12	1.9M	Preinstalled server image for Raspberry Pi Generic (64-bit ARM) computers (preinstalled SD Card image)
      # [TXT]	ubuntu-22.10-preinstalled-server-arm64+raspi.manifest	2022-10-19 08:32	15K	Preinstalled server image for Raspberry Pi Generic (64-bit ARM) computers (contents of live filesystem)

      # [   ]	jammy-preinstalled-desktop-arm64+raspi.img.xz	2022-12-31 09:02	2.0G	Preinstalled desktop image for Raspberry Pi Generic (64-bit ARM) computers (preinstalled SD Card image)
      # [   ]	jammy-preinstalled-desktop-arm64+raspi.img.xz.zsync	2022-12-31 09:03	4.0M	Preinstalled desktop image for Raspberry Pi Generic (64-bit ARM) computers (preinstalled SD Card image)
      # [TXT]	jammy-preinstalled-desktop-arm64+raspi.manifest	2022-12-31 09:02	48K	Preinstalled desktop image for Raspberry Pi Generic (64-bit ARM) computers (contents of live filesystem)

      # [   ] ubuntu-20.04-server-cloudimg-amd64-root.manifest       2022-12-13 22:16   17K  Ubuntu Server 20.04 LTS (Focal Fossa) released builds
      # [   ] ubuntu-20.04-server-cloudimg-amd64-root.tar.xz         2022-12-13 22:16  384M  Ubuntu Server 20.04 LTS (Focal Fossa) released builds
      # [   ] focal-server-cloudimg-amd64-root.manifest       2022-12-13 22:16   17K  Package manifest file
      # [   ] focal-server-cloudimg-amd64-root.tar.xz         2022-12-13 22:16  384M  Ubuntu Server 20.04 LTS (Focal Fossa) daily builds

      # [   ] ubuntu-20.04-minimal-cloudimg-amd64-root.manifest     2022-12-13 08:03   11K  Package manifest file
      # [   ] ubuntu-20.04-minimal-cloudimg-amd64-root.tar.xz       2022-12-13 08:03  104M  Ubuntu Minimal 20.04 LTS (Focal Fossa) released builds
      # [   ] focal-minimal-cloudimg-amd64-root.manifest     2022-12-13 05:52   11K  Package manifest file
      # [   ] focal-minimal-cloudimg-amd64-root.tar.xz       2022-12-13 05:52  104M  Ubuntu Minimal 20.04 LTS (Focal Fossa) daily builds

      # [   ]	ubuntu-base-22.04-base-amd64.tar.gz	2022-04-19 10:06	28M
      # [   ]	ubuntu-base-22.04-base-amd64.tar.gz.zsync	2022-04-21 14:15	100K

      # [TXT]	jammy-base-amd64.manifest	2022-12-31 04:59	2.8K
      # [   ]	jammy-base-amd64.tar.gz	2022-12-31 04:59	28M

      def files_of(*argv, daily: false, **opts)
        edition = argv[0] || opts[:edition] || "base"
        # release: (version | codename)
        release = argv[1] || opts[:release] || "22.04"
        arch = argv[2] || opts[:arch] || "amd64"
        devkit = argv[3] || opts[:devkit]

        keywords = [edition, arch]
        ignores = []

        keywords.push(devkit) unless devkit.nil?

        if %w[cloud minimal].include?(edition)
          keywords.shift
          keywords.push("-root")
          ignores = %w[wsl lxd squashfs]
        end

        url = RootFS::Distro::Ubuntu.url_of(edition, release, daily, arch: arch)
        return if url.nil?

        resp = RootFS::HTTP.get(url)
        body = resp.body
        files = RootFS::Data.from_sha256sum(body, keywords, ignores)
        { sha256sum: url, files: files }
      end
    end
  end
end
