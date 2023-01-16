# frozen_string_literal: true

module RootFS
  # Ubuntu mainfest style
  module Manifest
    def manifest_readlines(any, &block)
      if File.file?(any)
        IO.readlines(any, &block)
      else
        String(any).readlines(&block)
      end
    end

    def manifest_each_line(any, &block)
      if File.file?(any)
        IO.readlines(any, &block).each(&block)
      else
        String(any).readlines(&block)
      end
    end

    def manifest_package(any)
      lines = if File.file?(any)
                IO.readlines(any)
              else
                String(any).readlines
              end
      list = []
      lines.each do |line|
        pkg = line.include?("\t") ? line.split("\t")[0] : line.split(" ")[0]
        list.push(pkg)
      end
      list
    end
  end
end
