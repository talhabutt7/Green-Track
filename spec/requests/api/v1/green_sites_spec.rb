require 'rails_helper'

RSpec.describe "Api::V1::GreenSites", type: :request do
  let(:user) { create(:user) }
  let(:valid_attributes) { { name: "Amazon Rainforest", coordinates: "POINT(-62.325 2.316)" } }

  before do
    post '/api/v1/auth/login', params: { email: user.email, password: user.password }
    @token = JSON.parse(response.body)['token']
  end

  describe "POST /create" do
    it "creates a site with valid JWT" do
      post '/api/v1/green_sites',
           headers: { 'Authorization' => "Bearer #{@token}" },
           params: { green: valid_attributes }
      expect(response).to have_http_status(:created)
    end
  end
end