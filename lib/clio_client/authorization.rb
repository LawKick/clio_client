module ClioClient

  module Authorization


    def authorize_url(redirect_uri, state = nil)
      params = { response_type: :code, 
        client_id: self.client_id,
        redirect_uri: redirect_uri
      }
      params[:state] = state if state
      base_uri("/oauth/authorize", params).to_s
    end

    def authorize_with_code(redirect_uri, code)
      params = { code: code,
        grant_type: "authorization_code",
        client_id: self.client_id,
        client_secret: self.client_secret,
        redirect_uri: redirect_uri
      }
      uri = base_uri("/oauth/token")
      req = Net::HTTP::Post.new(uri.request_uri)
      req.set_form_data params
      credentials = make_request(req, uri)
      self.access_token = credentials["access_token"]
      credentials
    end

    def authorized?
      begin
        get("/users/who_am_i")
        true
      rescue ClioClient::Unauthorized
        false
      end
    end

    
  end
end
