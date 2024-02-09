class VideosController < ApplicationController
  def show
    video_name = params[:video_name]
    video_path = Rails.root.join('public', 'videos', video_name)

    if File.exist?(video_path)
      send_file video_path, disposition: 'inline'
    else
      head :not_found
    end
  end
end
