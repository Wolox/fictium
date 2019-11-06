shared_examples 'unauthorized when not logged in' do
  describe example 'when no account is signed in' do
    before do
      make_request
    end

    it 'responds with unauthorized status' do
      expect(response).to have_http_status(:unauthorized)
    end
  end
end

shared_examples 'unprocessable entity examples' do
  include_context 'with account login'

  before do
    make_request
  end

  it 'responds with unprocessable entity status' do
    expect(response).to have_http_status(:unprocessable_entity)
  end
end

shared_examples 'not found examples' do
  before do
    make_request
  end

  it 'responds with not_found status' do
    expect(response).to have_http_status(:not_found)
  end
end
