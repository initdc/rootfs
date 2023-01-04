# frozen_string_literal: true

module RootFS
  module Parse
    extend self

    def _str_in_arr(any, distro, attr, data)
      err_msg = "Valid #{distro} #{attr}: #{data}"

      return { "#{attr}": any } if data.include?(any)

      puts err_msg
    end

    def _arr_in_arr(any, distro, attr, data)
      err_msg = "Valid #{distro} #{attr}: #{data}"

      args = any.instance_of?(Array) ? any : [any]
      if args.empty?
        puts err_msg
        return
      end

      res = []
      not_valid = []
      args.each do |arg|
        if data.include?(arg)
          res.push(arg)
        else
          not_valid.push(arg)
        end
      end

      unless not_valid.empty?
        puts "Not valid: #{not_valid}"
        puts err_msg
      end

      { "#{attr}": res } unless res.empty?
    end
  end
end
