class LocationsController < ApplicationController
  
  # GET /locations (XML/JSON)
  def index
    if params[:lat] && params[:lng] && params[:uid] && params[:lat].length > 0 && params[:lng].length > 0 && params[:uid].length > 0
      @origin = [params[:lat], params[:lng]]
      @locations = Location.all.sort_by_distance_from(@origin).take(Setting.get_limit)
      if Setting.get_encrypt && !params[:no_encrypt]
        encrypted_data = encrypt_with_device_id(@locations.as_json(:usercon => params).to_json, params[:uid])
        render json: { response: encrypted_data }
      else
        render json: @locations.as_json(:usercon => params)
      end
    else
      head :bad_request
    end
  end
  
  def encrypt_with_device_id(data_to_encrypt, device_id)
    aes = OpenSSL::Cipher::AES256.new(:CBC)
    aes.encrypt
    key = Digest::SHA256.digest(device_id)
    iv = aes.random_iv
    aes.key = key
    aes.iv = iv
    Base64.strict_encode64(iv + (aes.update(data_to_encrypt) + aes.final))
  end
    
end
