describe BooksController do
  describe 'GET #index' do
    subject(:make_request) { get :index, params: params }

    let(:params) { { topic_id: topic_id } }
    let(:topic_id) { 1 }

    context 'when a valid topic is given' do
      before do
        make_request
      end

      it 'responds with ok status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when an invalid topic is given' do
      let(:topic_id) { -1 }

      before do
        make_request
      end

      it 'responds with not_found status' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
