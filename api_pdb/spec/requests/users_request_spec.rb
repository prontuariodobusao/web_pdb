require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET users' do
    context 'request with headers valids' do
      before do
        create_list(:user, 5)
        resquest_get(url: users_path, headers: authenticate_header)
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(response).to match_json_schema('api/v1/users') }
    end
  end
end
