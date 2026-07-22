describe "Author", type: :request do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:author) { create(:author, user: user) }

  let(:valid_params) do
    {
      first_name: "Julian",
      last_name: "Solis"
    }
    end

  let(:new_params) {
    {
      first_name: "Updated"
    }
  }

  describe "GET /index" do
    before { author }

    it "returns a successful response including authors list" do
      get authors_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include(author.first_name)
    end
  end

  describe "GET /show" do
    it "renders a successful response including an author" do
      get author_path(author)
      expect(response).to have_http_status(:success)
      expect(response.body).to include(author.first_name)
    end
  end

  describe "GET /new" do
    context "when user is signed in" do
      before { sign_in user }

      it "renders a successful response" do
        get new_author_path
        expect(response).to be_successful
      end
    end

    context "when user is not signed in" do
      it "redirects to the login page" do
        get new_author_path
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET /edit" do
    before { sign_in user }
    it "renders a successful response" do
      get edit_author_url(author)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "when user signed in" do
      before { sign_in user }

      it "creates a new author" do
        expect {
          post authors_url, params: { author: valid_params }
        }.to change(Author, :count).by(1)
      end
    end

    context "when user is not signed in" do
      it "does not create a new author" do
        expect {
          post authors_url, params: { author: valid_params }
        }.not_to change(Author, :count)
      end
    end
  end

  describe "PATCH /update" do
    context "when user is signed in and authorized" do
      before { sign_in user }

      it "updates the requested author" do
        patch author_url(author), params: { author: new_params }
        author.reload
        expect(author.first_name).to eq("Updated")
      end
    end

    context "when the user is signed in and not authorized" do
      before { sign_in another_user }

      it "redirects to the root path with an alert" do
        patch author_url(author), params: { author: new_params }
        expect(response).to redirect_to(root_path)
        follow_redirect!

        expect(flash[:alert]).to eq("You are not authorized to perform this action.")
      end
    end

    context "when user is not signed in" do
      it "does not update the requested author" do
        patch author_url(author), params: { author: new_params }
        author.reload
        expect(author.first_name).not_to eq("Updated")
      end
    end
  end

  describe "DELETE /destroy" do
    context "when user is signed in and authorized" do
      before { author }
      before { sign_in user }

      it "destroys the requested author" do
        expect {
          delete author_url(author)
        }.to change(Author, :count).by(-1)
      end
    end

    context "when the user is signed in and not authorized" do
      before { author }
      before { sign_in another_user }

      it "redirects to the root path with an alert" do
        delete author_url(author)
        expect(response).to redirect_to(root_path)
        follow_redirect!

        expect(flash[:alert]).to eq("You are not authorized to perform this action.")
      end
    end

    context "when user is not signed in" do
      before { author }

      it "does not destroy the requested author" do
        expect {
          delete author_url(author)
        }.not_to change(Author, :count)
      end
    end
  end
end
