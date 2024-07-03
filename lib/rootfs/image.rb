# frozen_string_literal: true

require "cr"

module RootFS
  module Image
    def creat_blank(name, bs = "1MB", size)
      Cr.run("dd if=/dev/zero of=#{name} bs=#{bs} count=0 seek=#{size}")
    end

    def resize
    end

    def from_conf
    end

    def dump_blank
    end

    def list(img)
      Cr.run("parted #{img} unit MiB print")
    end

    def dir_sum(dir, kilo: flase)
      kilo_opt = kilo ? "--si " : ""
      output = Cr.output("du --summarize --block-size=1M #{kilo_opt}#{dir}")
      output.split(" ").first.to_i
    end

    def dir_inodes(dir)
      output = Cr.output("du --summarize --inodes #{dir}")
      output.split(" ").first.to_i
    end
  end
end
