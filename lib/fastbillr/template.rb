module Fastbillr
  class Template < Fastbillr::Dash
    [
      :template_id,
      :template_name, :template_hash
    ].each { |property| property property }

    class << self
      def all
        result = []
        offset = 0
        limit = MAX_RESULT_ELEMENTS
        begin
          templates = Fastbillr::Request.post({"SERVICE" => "template.get", "OFFSET" => offset, "LIMIT" => limit}.to_json)["TEMPLATES"]
          last_template = templates.last
          result += templates.map { |customer| new(customer) }
          offset = result.count
        end while templates.count == limit
        result
      end
    end
  end
end
