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
    before { list }

    context "when user is signed in and has lists" do
      before { sign_in user }
      it "returns a successful response including user's lists" do
        get lists_path
        expect(response).to have_http_status(:success)
        expect(response.body).to include(list.name)
      end
    end

    context "when user is signed in and have no lists" do
      before { sign_in another_user }
      it "returns a successful response without another user's list" do
        get lists_path
        expect(response).to have_http_status(:success)
        expect(response.body).not_to include(list.name)
      end
    end

    context "when user is not signed in" do
      it "redirects to the sign in page" do
        get lists_path

        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET /show" do
    before { list }

    context "when user is a list's owner and signed in" do
      before { sign_in user }
      it "returns a successful response" do
        get list_path(list)
        expect(response).to have_http_status(:success)
        expect(response.body).to include(list.name)
      end
    end

    context "when user is not a list's owner" do
      before { sign_in another_user }
      it "returns an error response" do
        get list_path(list)
        expect(response).to have_http_status(:not_found)
      end
    end

    context "when user is not signed in" do
      it "redirects to the sign in page" do
        get lists_path

        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET /new" do
    context "when user is signed in" do
      before { sign_in user }

      it "renders a successful response" do
        get new_list_path
        expect(response).to be_successful
      end
    end

    context "when user is not signed in" do
      it "redirects to the sign in page" do
        get lists_path

        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET /edit" do
    context "when user is signed in and list's owner" do
      before { sign_in user }
      it "renders a successful response" do
        get edit_list_url(list)
        expect(response).to be_successful
      end
    end

    context "when user is signed in and not list's owner" do
      before { sign_in another_user }
      it "returns an error response" do
        get edit_list_url(list)
        expect(response).to have_http_status(:not_found)
      end
    end

    context "when user is not signed in" do
      before { sign_in another_user }
      it "returns an error response" do
        get edit_list_url(list)
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "POST /create" do
    context "when user signed in" do
      before { sign_in user }

      it "creates a new list" do
        expect {
          post lists_url, params: { list: valid_params }
        }.to change(List, :count).by(1)
      end
    end

    context "when user is not signed in" do
      it "does not create a new list" do
        expect {
          post lists_url, params: { list: valid_params }
        }.not_to change(List, :count)
      end
    end
  end

  describe "PATCH /update" do
    context "when user is signed in and authorized" do
      before { sign_in user }

      it "updates the requested list" do
        patch list_url(list), params: { list: new_params }
        list.reload
        expect(list.name).to eq("Updated list's name")
      end
    end

    context "when the user is signed in and not authorized" do
      before { sign_in another_user }

      it "returns an error response" do
        get edit_list_url(list)
        expect(response).to have_http_status(:not_found)
      end
    end

    context "when user is not signed in" do
      it "does not update the requested list" do
        patch list_url(list), params: { list: new_params }
        list.reload
        expect(list.name).not_to eq("Updated list's name")
      end
    end
  end

  describe "DELETE /destroy" do
    context "when user is signed in and authorized" do
      before { list }
      before { sign_in user }

      it "destroys the requested list" do
        expect {
          delete list_url(list)
        }.to change(List, :count).by(-1)
      end
    end

    context "when the user is signed in and not authorized" do
      before { list }
      before { sign_in another_user }

      it "returns an error response" do
        get edit_list_url(list)
        expect(response).to have_http_status(:not_found)
      end
    end

    context "when user is not signed in" do
      before { list }

      it "redirects to the sign in page" do
        get lists_path

        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
