require 'uri'

module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    #
    # You haven't done routing yet; but assume route params will be
    # passed in as a hash to `Params.new` as below:
    def initialize(req, route_params = {})
      @params = {}
      if !req.query_string.nil?
        @params = parse_www_encoded_form(req.query_string)
      end
      # query string looks like: "key=val&key2=val2"
    end

    def [](key)
      key.to_sym if key.is_a?(String)
      @params[key]
    end

    def to_s
      @params.to_json.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      # e.g. parse_www_encoded_form(@query_string)
      # this takes: "key=val&key2=val2"
      # to:  [["key", "val"], ["key2", "val2"]]

      current_params = {}
      query_pairs = URI::decode_www_form(www_encoded_form, enc=Encoding::UTF_8)

      query_pairs.each do |pair|
        current_params[pair.first] = pair.last
      end

      p build_params(query_pairs)
      # current_params = build_params(query_pairs)

      # @params = build_params(data)
    end

    def build_params(data)
      params = {}

      data.each do |pair|
        current = params # we're pointing to params. when we update current, we're also updating params
        key = pair.first
        value = pair.last
        keys.each_with_index do |key, idx|
          if idx == keys.length - 1
            current[key] = value
          else
            current[key] ||= {}
            current = current[key]
          end
        end
      end

      params
    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      key.split(/\]\[|\[|\]/)
    end
  end
end
