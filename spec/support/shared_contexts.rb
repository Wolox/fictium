shared_context 'with account login' do
  before do
    request.headers['Authorization'] = 'Bearer <token>'
  end
end
