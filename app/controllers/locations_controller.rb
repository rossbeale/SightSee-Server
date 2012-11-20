class LocationsController < ApplicationController
  
  # GET /locations (XML/JSON)
  def index
    if params[:lat] && params[:lng] && params[:uid] && params[:lat].length > 0 && params[:lng].length > 0 && params[:uid].length > 0
      @origin = [params[:lat], params[:lng]]
      @locations = Location.all.sort_by_distance_from(@origin).take(Setting.get_limit)
      if Setting.get_encrypt
        d = OpenSSL::Cipher.new("aes-256-cbc")
        @secret = OpenSSL::PKCS5.pbkdf2_hmac_sha1(params[:uid], "tourdroid", 1024, d.key_len)
        cipher = OpenSSL::Cipher::Cipher.new("aes-256-cbc")
        iv = cipher.random_iv
        cipher.encrypt
        cipher.key = @secret
        cipher.iv = iv
        encrypted_data = cipher.update(@locations.as_json(:usercon => params).to_json)
        encrypted_data << cipher.final
        encrypted_data = [encrypted_data, iv].map {|v| ::Base64.strict_encode64(v)}.join("--").to_s
        render json: { response: encrypted_data }
      else
        render json: @locations.as_json(:usercon => params)
      end
    else
      head :bad_request
    end
  end
  
end
