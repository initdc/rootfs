# frozen_string_literal: true

module RootFS
  module Parse
    extend self

    def _str_in_arr(any, distro, attr, data)
      err_msg = "Valid #{distro} #{attr}: #{data}"

      puts err_msg unless any

      str = any.to_s
      puts err_msg if str.empty?

      return { "#{attr}": str } if data.include?(str)

      puts err_msg
    end
  end
end
