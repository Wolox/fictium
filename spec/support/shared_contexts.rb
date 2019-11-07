shared_context 'with account login' do
  before do
    request.headers['Authorization'] = 'Bearer <token>'
  end
end

shared_context 'with JSON API' do
  before do
    request.headers.merge!(
      Accept: 'application/json',
      'Content-Type': 'application/json'
    )
  end
end
