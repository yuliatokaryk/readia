describe "Lists", type: :request do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:list) { create(:list, user: user) }

  let(:valid_params) do
    {
      name: "Favorite",
      description: "My favorite books"
    }
  end

  let(:new_params) {
    {
      name: "Updated list's name"
    }
  }
  describe "GET /index" do
    before { sign_in user }
    before { list }

    it "returns a successful response including user's lists" do
      get lists_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include(list.name)
    end
  end
end
