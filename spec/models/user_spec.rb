describe User, type: :model do
  let(:user) { create(:user) }
  describe "default lists" do
    it "creates the default lists after user creation" do
      expect(user.lists.pluck(:name)).to contain_exactly(
        "Want to Read",
        "Currently Reading",
        "Read"
      )
    end

    it "creates default lists marked as default" do
      expect(user.lists.where(default: true).count).to eq(3)
    end
  end
end
