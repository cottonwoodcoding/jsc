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
    image_shack_images.each do |image_data|
      images << {image_id: image_data['id'], image_link: image_data['direct_link']}
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

  def image_shack_images
    result = image_shack_api_call("http://api.imageshack.com/v2/user/jakesorce/images")
    result['images'] unless result.nil?
  end

  def image_shack_albums
    result = image_shack_api_call("http://api.imageshack.com/v2/user/jakesorce/albums")
    result['albums'] unless result.nil?
  end

  def thumbnail(direct_link)
    parts = direct_link.split(".")
    length = parts.length
    parts.insert(length - 1, 'th').join('.')
  end

  def image_shack_api_call(url, type = :get, params = {})
    c = Curl::Easy.new
    c.url = "#{url}?#{Curl::postalize(params)}"
    c.method type
    c.ssl_verify_peer = false
    c.perform
    c.response_code == 200 ? JSON.parse(c.body)['result'] : nil
  end
end
