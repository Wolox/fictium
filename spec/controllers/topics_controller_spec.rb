describe TopicsController do
  include_context 'with JSON API'

  describe action 'GET #index' do
    subject(:make_request) { get :index, params: { limit: 10, page: 1 } }

    params_in :cookie do
      search_id schema: { type: 'string' }
    end

    params_in :query do
      limit schema: { type: 'integer' }
      page schema: { type: 'integer' }
    end

    describe example 'when a valid request is processed' do
      default_example

      before do
        request.cookies[:search_id] = '<Search Token>'
        make_request
      end

      it 'responds with ok status' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe action 'GET #show' do
    subject(:make_request) { get :show, params: { id: topic_id } }

    let(:topic_id) { 1 }

    describe example 'when a valid topic is given' do
      default_example

      before do
        make_request
      end

      it 'responds with ok status' do
        expect(response).to have_http_status(:ok)
      end
    end

    describe example 'when an invalid topic is given' do
      let(:topic_id) { -1 }

      include_examples 'not found examples'
    end
  end

  describe action 'POST #create' do
    subject(:make_request) { post :create, params: params }

    let(:params) { {} }

    describe example 'when a logged in user passes valid parameters' do
      include_context 'with account login'

      default_example
      require_request_body!

      let(:params) { { topic: { name: 'New Topic' } } }

      before do
        make_request
      end

      it 'responds with created status' do
        expect(response).to have_http_status(:created)
      end
    end

    describe example 'when a logged in user passes invalid parameters' do
      let(:params) { {} }

      include_examples 'unprocessable entity examples'
    end

    include_examples 'unauthorized when not logged in'
  end

  describe action 'PATCH #update' do
    subject(:make_request) { patch :update, params: params }

    let(:params) { { id: 1, topic: { name: 'New name' } } }

    describe example 'when a logged in user passes valid parameters' do
      include_context 'with account login'

      default_example
      require_request_body!
      request_schema type: 'object', required: %w[tag], properties: {
        tag: {
          type: 'object',
          properties: {
            name: {
              type: 'string'
            }
          },
          required: %w[name]
        }
      }
      response_schema type: 'object', properties: {
        id: { type: 'integer' },
        name: { type: 'string' }
      }

      before do
        make_request
      end

      it 'responds with ok status' do
        expect(response).to have_http_status(:ok)
      end
    end

    describe example 'when a logged in user passes invalid parameters' do
      include_context 'with account login'

      let(:params) { { id: 1 } }

      include_examples 'unprocessable entity examples'
    end

    describe example 'when the topic does not exists' do
      include_context 'with account login'

      let(:params) { { id: -1 } }

      include_examples 'not found examples'
    end

    include_examples 'unauthorized when not logged in'
  end

  describe action 'DELETE #destroy' do
    subject(:make_request) { delete :destroy, params: params }

    let(:params) { { id: 1 } }

    describe example 'when a logged in user gives a valid topic' do
      include_context 'with account login'

      default_example

      before do
        make_request
      end

      it 'responds with no content status' do
        expect(response).to have_http_status(:no_content)
      end
    end

    describe example 'when the topic does not exists' do
      include_context 'with account login'

      let(:params) { { id: -1 } }

      include_examples 'not found examples'
    end

    include_examples 'unauthorized when not logged in'
  end
end
