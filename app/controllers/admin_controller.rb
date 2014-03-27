class AdminController < ApplicationController

  def index
    redirect_to :settings
  end

  def settings
    @story = Setting.find_by_key('story').value rescue ''
    @albums_hash = {}
    image_shack_albums.each do |album|
      @albums_hash[album['id']] = album['title']
    end
  end

  def update_story
    story = Setting.where(key: 'story').first_or_create
    story.update_attribute(:value, params['story'])
    story.save!
    flash[:notice] = 'Our Story Updated!'
    render js: 'window.location.reload();'
  end

  def album_images
    images = []
    result = image_shack_api_call("https://api.imageshack.us/v1/albums/#{params[:album_id]}")
    result['images'].each do |image_data|
      images << {image_id: image_data['id'], image_link: image_shack_image_src(image_data['server'], image_data['filename'])}
    end
    render json: images.to_json
  end

  def albums
    render json: image_shack_albums
  end

  private

  def hash_array_block
    lambda { |h, k| h[k] = Array.new() }
  end

  def image_shack_auth
    result = image_shack_api_call('https://api.imageshack.us/v1/user/login', :post,
                                  {user: CONFIG['image-shack-username'], password: CONFIG['image-shack-password']})
    result['auth_token'] unless result.nil?
  end

  def image_shack_albums
    result = image_shack_api_call("https://api.imageshack.us/v1/user/#{CONFIG['image-shack-username']}/albums")
    result['albums'] unless result.nil?
  end

  def image_shack_image_src(server, filename)
    result = image_shack_api_call("https://api.imageshack.us/v1/images/#{server}/#{filename}")
    result['direct_link'] unless result.nil?
  end

  def image_shack_api_call(url, type = :get, params={})
    response = Curl.send(type.to_sym, url, params)
    response.response_code == 200 ? JSON.parse(response.body)['result'] : nil
  end
end
