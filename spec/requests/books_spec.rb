describe "Books", type: :request do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:author) { create(:author, user: user) }
  let(:book) { create(:book, author: author, user: user) }

  let(:valid_params) do
    {
      title: "Pride and Prejudice",
      published_at: Date.current,
      author_id: author.id
    }
  end

  let(:new_params) {
    {
      title: "Updated title"
    }
  }

  describe "GET /index" do
    before { book }

    it "returns a successful response including books list" do
      get books_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include(book.title)
    end
  end

  describe "GET /show" do
    it "renders a successful response including a book" do
      get book_path(book)
      expect(response).to have_http_status(:success)
      expect(response.body).to include(book.title)
    end
  end

  describe "GET /new" do
    context "when user is signed in" do
      before { sign_in user }

      it "renders a successful response" do
        get new_book_path
        expect(response).to be_successful
      end
    end

    context "when user is not signed in" do
      it "redirects to the login page" do
        get new_book_path
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET /edit" do
    before { sign_in user }
    it "renders a successful response" do
      get edit_book_url(book)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "when user signed in" do
      before { sign_in user }

      it "creates a new book" do
        expect {
          post books_url, params: { book: valid_params }
        }.to change(Book, :count).by(1)
      end
    end

    context "when user is not signed in" do
      it "does not create a new book" do
        expect {
          post books_url, params: { book: valid_params }
        }.not_to change(Book, :count)
      end
    end
  end

  describe "PATCH /update" do
    context "when user is signed in and authorized" do
      before { sign_in user }

      it "updates the requested book" do
        patch book_url(book), params: { book: new_params }
        book.reload
        expect(book.title).to eq("Updated title")
      end
    end

    context "when the user is signed in and not authorized" do
      before { sign_in another_user }

      it "redirects to the root path with an alert" do
        patch book_url(book), params: { book: new_params }
        expect(response).to redirect_to(root_path)
        follow_redirect!

        expect(flash[:alert]).to eq("You are not authorized to perform this action.")
      end
    end

    context "when user is not signed in" do
      it "does not update the requested book" do
        patch book_url(book), params: { book: new_params }
        book.reload
        expect(book.title).not_to eq("Updated title")
      end
    end
  end

  describe "DELETE /destroy" do
    context "when user is signed in and authorized" do
      before { book }
      before { sign_in user }

      it "destroys the requested book" do
        expect {
          delete book_url(book)
        }.to change(Book, :count).by(-1)
      end
    end

    context "when the user is signed in and not authorized" do
      before { book }
      before { sign_in another_user }

      it "redirects to the root path with an alert" do
        delete book_url(book)
        expect(response).to redirect_to(root_path)
        follow_redirect!

        expect(flash[:alert]).to eq("You are not authorized to perform this action.")
      end
    end

    context "when user is not signed in" do
      before { book }

      it "does not destroy the requested book" do
        expect {
          delete book_url(book)
        }.not_to change(Book, :count)
      end
    end
  end
end
