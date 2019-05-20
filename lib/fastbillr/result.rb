module Fastbillr
  class Result

    class << self
      def process(response)
        raise Error, "Response body is empty (status: #{response.status}). Please verify your API credentials." unless response.body.present? || [200, 201].include?(response.status)
        parsed_body = JSON.parse(response.body)
        raise Error, parsed_body["RESPONSE"]["ERRORS"].first unless response.status == 200
        parsed_body["RESPONSE"]
      end
    end

  end
end
