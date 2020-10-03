class ApiConstraints
    def initialize options
        @default = options[:default]
        @version = options[:version]
    end

    def matches? req
        @default || req.headers['Accept'].include?("application/vnd.market.v#{@version}")
    end
end