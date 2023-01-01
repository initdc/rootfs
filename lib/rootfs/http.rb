# frozen_string_literal: true

require "faraday"

module RootFS
  module HTTP
    def get(url)
      resp = Faraday.get(url)
      code = resp.status
      if code >= 300 && code < 400
        new_url = resp.headers["Location"]
        get(new_url)
      else
        resp
      end
    end

    def head(url)
      resp = Faraday.head(url)
      code = resp.status
      if code >= 300 && code < 400
        new_url = resp.headers["Location"]
        head(new_url)
      else
        resp
      end
    end

    def valid?(url)
      resp = head(url)
      code = resp.status
      code >= 200 && code < 300
    end
  end
end
