describe "Books", type: :request do
  let(:user) { create(:user) }
  let(:author) { create(:author, user: user) }
  let(:book) { create(:book, author: author, user: user) }

  describe "GET /books" do
    before { book }

    it "returns a successful response including books list" do
      get books_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include(book.title)
    end
  end

  describe "GET /book" do
    it "renders a successful response including a book" do
      get book_path(book)
      expect(response).to have_http_status(:success)
      expect(response.body).to include(book.title)
    end
  end

  describe "GET /new" do
    context "when user is signed in" do
      before do
        sign_in user
      end
      it "renders a successful response when user is signed in" do
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
      it "renders a successful response" do
        get edit_book_url(book)
        expect(response).to be_successful
    end
  end

  describe "POST /create" do
    
  end

  describe "PATCH /update" do
    
  end

  describe "DELETE /destroy" do
    
  end
end
