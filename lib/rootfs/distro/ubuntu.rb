# frozen_string_literal: true

require_relative "../http"
require_relative "../data"
require_relative "ubuntu/arch"
require_relative "ubuntu/edition"
require_relative "ubuntu/file"
require_relative "ubuntu/url"

module RootFS
  module Distro
    module Ubuntu
      extend self

      Methods = {
        arch?: ARCH,
        edition?: EDITION,
        dev?: DEV,
        interim?: INTERIM,
        lts?: LTS,
        esm?: ESM
      }.freeze

      Methods.each do |name, data|
        if data.instance_of?(Array)
          define_method(name) do |any = nil|
            str = any.to_s
            data.include?(str)
          end
        elsif data.instance_of?(Hash)
          define_method(name) do |any = nil|
            str = any.instance_of?(0.1.class) ? format("%.2f", any) : any.to_s
            data.each do |code, ver|
              return true if str == code.to_s
              return true if str.start_with?(ver)
            end
            false
          end
        end
      end
    end
  end
end
