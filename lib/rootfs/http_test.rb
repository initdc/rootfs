# frozen_string_literal: true

require_relative "http"

class MyClass
  extend RootFS::HTTP
  include RootFS::HTTP
end

u = MyClass.new
url = "https://cloud-images.ubuntu.com/minimal/releases/jammy/release/SHA256SUMS"
gentoo = "https://bouncer.gentoo.org/fetch/root/all/releases/amd64/autobuilds/20221225T170313Z/stage3-amd64-systemd-20221225T170313Z.tar.xz"

p u.valid?(gentoo)
