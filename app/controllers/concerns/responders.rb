module Responders
    def json_response obj, status
        render json: obj, status: status , location: [:api, obj]
    end
    def json_error_response obj, status
        render json: obj, status: status
    end

end