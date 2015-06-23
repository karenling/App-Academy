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

      @params = route_params

      if req.query_string
        @params = parse_www_encoded_form(req.query_string)
      elsif req.body
        @params = parse_www_encoded_form(req.body)
      end

      # @params = route_params.merge(query_string_params).merge(post_body_params)
      # query string looks like: "key=val&key2=val2"
    end

    def [](key)

      # we're able to access the key if it's a string
      # but we also want to be able to do it if someone passes a symbol
      if key.is_a?(Symbol)
        key = key.to_s
      end
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
      # e.g. parse_www_encoded_form(query_string)
      # where query_string: "key=val&key2=val2"
      # parse_www_encoded_form(query_string) should give us  [["key", "val"], ["key2", "val2"]]

      current_params = {}
      query_pairs = URI::decode_www_form(www_encoded_form, enc=Encoding::UTF_8)

      query_pairs.each do |pair|
        current_params[pair.first] = pair.last
      end

      build_params(query_pairs)
      # p current_params
      # p build_params(query_pairs)
      # current_params = build_params(query_pairs)

      # @params = build_params(data)
    end

    def build_params(data)
      params = {}
      data.each do |pair| #iterating through a pair of data
        current = params # we're pointing to params. when we update current, we're also updating params
        keys = parse_key(pair.first)
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
