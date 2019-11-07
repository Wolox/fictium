describe BooksController do
  include_context 'with JSON API'

  # While automatically inferred, they can be also manually specified:
  base_path '/topics/{topic_id}/books'
  resource_name 'book'
  resource_summary 'Lists all books for a specific topic.'
  resource_description <<~HEREDOC
    This will fail if the topic does not exists.
    The results are not paginated.
  HEREDOC
  resource_tags 'topics', 'list'

  describe action 'GET #index' do
    subject(:make_request) { get :index, params: params }

    params_in :path do
      topic_id schema: { type: 'integer' }, description: "The topic's id"
    end

    # This is also auto detected, but can be manually changed
    path ''
    deprecate!
    action_docs url: 'http://docstoaction.com'

    let(:params) { { topic_id: topic_id } }
    let(:topic_id) { 1 }

    describe example 'when a valid topic is given' do
      before do
        request.headers.merge!('X-Extra-Header': 'Some value')
        make_request
      end

      default_example

      it 'responds with ok status' do
        expect(response).to have_http_status(:ok)
      end
    end

    describe example 'when an invalid topic is given' do
      let(:topic_id) { -1 }

      include_examples 'not found examples'
    end
  end
end
