describe "AuthorPolicy", type: :policy do
  let(:user) { create(:user) }
  let(:user_1) { create(:user) }

  let(:author) { create(:author, user: user) }

  describe "#update?" do
    context "when user owns the author" do
      let(:policy) { AuthorPolicy.new(user, author) }
      it "allows updating" do
        expect(policy.update?).to be(true)
      end
    end

    context "when user does not own the author" do
      let(:policy) { AuthorPolicy.new(user_1, author) }
      it "does not allow updating" do
        expect(policy.update?).to be(false)
      end
    end
  end

  describe "#destroy?" do
    context "when user owns the author" do
      let(:policy) { AuthorPolicy.new(user, author) }
      it "allows destroying" do
        expect(policy.destroy?).to be(true)
      end
    end

    context "when user does not own the author" do
      let(:policy) { AuthorPolicy.new(user_1, author) }
      it "does not allow destroying" do
        expect(policy.destroy?).to be(false)
      end
    end
  end
end
