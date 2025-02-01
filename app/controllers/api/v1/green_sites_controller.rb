# app/controllers/api/v1/green_sites_controller.rb
module Api::V1
  class GreenSitesController < ApplicationController
    before_action :authenticate_api_user!

    def create
      @site = GreenSite.new(site_params)
      if @site.save
        render json: @site, status: :created
      else
        render json: @site.errors, status: :unprocessable_entity
      end
    end

    private

    def authenticate_api_user!
      header = request.headers['Authorization']
      token = header.split(' ').last if header
      begin
        decoded = JWT.decode(token, ENV['DEVISE_JWT_SECRET_KEY']).first
        @current_user = User.find(decoded['sub'])
      rescue
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end

    def site_params
      params.require(:green_site).permit(:name, :taxonomy_code, :coordinates)
    end
  end
end