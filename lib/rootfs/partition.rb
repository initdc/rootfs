# frozen_string_literal: true

require "cr"
require "json"

module RootFS
  module Partition
    def list(img)
      Cr.run("parted #{img} unit MiB print")
    end

    # https://wiki.archlinux.org/title/persistent_block_device_naming
    def label(par, label)
      type = Cr.output("mount -l | grep #{par}").split(" ")[4]
      case type
      when "swap"
        `swaplabel -L '#{label}' #{par}`
      when "ext2", "ext3", "ext4"
        `e2label #{par} '#{label}'`
      when "vfat"
        `fatlabel #{par} '#{label}'`
      when "btrfs"
        `btrfs filesystem label #{par} '#{label}'`
      when "exfat"
        `exfatlabel #{par} '#{label}'`
      when "ntfs"
        `ntfslabel #{par} '#{label}'`
      else
        puts "filesystem type not supported by library"
      end
    end

    # https://wiki.archlinux.jp/index.php/%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%82%B7%E3%82%B9%E3%83%86%E3%83%A0?rdfrom=https%3A%2F%2Fwiki.archlinux.org%2Findex.php%3Ftitle%3DFormat_a_device_%28%25E6%2597%25A5%25E6%259C%25AC%25E8%25AA%259E%29%26redirect%3Dno#%E3%83%87%E3%83%90%E3%82%A4%E3%82%B9%E3%81%AE%E3%83%95%E3%82%A9%E3%83%BC%E3%83%9E%E3%83%83%E3%83%88
    # https://wiki.alpinelinux.org/wiki/Filesystems
    def format(dev_par, type)
      Cr.run("mkfs -t #{type} #{dev_par}")
    end

    def mount_single(img, path)
      puts "mounting single partition image #{img} on #{path}"
      `mount -o loop #{img} #{path}`
    end

    def unmount(path)
      puts "unmounting #{path}"
      `umount #{path}`
    end

    def auto_mount(img)
      raise ArgumentError, "filename or path can not include white space" if img.include?(" ")

      Cr.output("losetup --find --show --partscan #{img}")
    end

    def auto_unmount_img(img)
      Cr.each_line("losetup --associated #{img}", chomp: true) do |line|
        dev_loop = line.split(" ").first.delete_suffix(":")
        Cr.run("losetup --detach #{dev_loop}")
      end
    end

    def auto_unmount_path(path)
      names = []
      results = JSON.parse(Cr.output("lsblk --json"))
      results["blockdevices"].each do |dev|
        name = dev["name"]
        mountpoints = dev["mountpoints"]
        if mountpoints.include?(path)
          unmount(path)
          names.push(name)
        end

        children = dev["children"]
        next unless children

        should_add = false
        children.each do |par|
          mountpoints = par["mountpoints"]
          if mountpoints.include?(path)
            unmount(path)
            should_add = true
          end
        end
        names.push(name) if should_add
      end

      names.uniq.each do |name|
        Cr.run("losetup --detach /dev/#{name}")
      end
    end

    def auto_unmount(any)
      if Cr.system?("test -f #{any}")
        auto_unmount_img(any)
      else
        auto_unmount_path(any)
      end
    end

    def mount_par(par, path)
      puts "mounting #{par} on #{path}"
      `mount #{par} #{path}`
    end

    def ask_mount(img = nil, path = nil)
      unless img
        print "which image to mount: "
        img = gets.chomp
      end
      dev_loop = auto_mount(img)
      list(img)
      print "which partition to mount: "
      num = gets.chomp
      unless path
        print "where to mount: "
        path = gets.chomp
      end
      mount_par("#{dev_loop}p#{num}", path)
    end

    def mount_combined(img, num, path)
      dev_loop = auto_mount(img)
      mount_par("#{dev_loop}p#{num}", path)
    end

    # https://wiki.alpinelinux.org/wiki/How_to_make_a_cross_architecture_chroot
    def mount_dev(path)
      puts "mounting dev on #{path}"
      `mount -o bind /sys #{path}/sys`
      `mount -o bind /proc #{path}/proc`
      `mount -o bind /dev #{path}/dev`
      `mount -o bind /dev/pts #{path}/dev/pts`
      `mount -o bind /run #{path}/run`
    end

    def unmount_dev(path)
      puts "unmounting dev on #{path}"
      `umount #{path}/run`
      `umount #{path}/dev/pts`
      `umount #{path}/dev`
      `umount #{path}/proc`
      `umount #{path}/sys`

      sleep 2
    end
  end
end
