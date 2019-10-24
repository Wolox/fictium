describe TopicsController do
  describe 'GET #index' do
    subject(:make_request) { get :index }

    context 'when a valid request is processed' do
      before do
        make_request
      end

      it 'responds with ok status' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET #show' do
    subject(:make_request) { get :show, params: { id: topic_id } }

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

      include_examples 'not found examples'
    end
  end

  describe 'POST #create' do
    subject(:make_request) { post :create, params: params }

    let(:params) { {} }

    context 'when a logged in user passes valid parameters' do
      include_context 'with account login'

      let(:params) { { topic: { name: 'New Topic' } } }

      before do
        make_request
      end

      it 'responds with created status' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when a logged in user passes invalid parameters' do
      let(:params) { {} }

      include_examples 'unprocessable entity examples'
    end

    include_examples 'unauthorized when not logged in'
  end

  describe 'PATCH #update' do
    subject(:make_request) { patch :update, params: params }

    let(:params) { { id: 1, topic: { name: 'New name' } } }

    context 'when a logged in user passes valid parameters' do
      include_context 'with account login'

      before do
        make_request
      end

      it 'responds with ok status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when a logged in user passes invalid parameters' do
      include_context 'with account login'

      let(:params) { { id: 1 } }

      include_examples 'unprocessable entity examples'
    end

    context 'when the topic does not exists' do
      include_context 'with account login'

      let(:params) { { id: -1 } }

      include_examples 'not found examples'
    end

    include_examples 'unauthorized when not logged in'
  end

  describe 'DELETE #destroy' do
    subject(:make_request) { delete :destroy, params: params }

    let(:params) { { id: 1 } }

    context 'when a logged in user gives a valid topic' do
      include_context 'with account login'

      before do
        make_request
      end

      it 'responds with no content status' do
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when the topic does not exists' do
      include_context 'with account login'

      let(:params) { { id: -1 } }

      include_examples 'not found examples'
    end

    include_examples 'unauthorized when not logged in'
  end
end
