describe "BookPolicy", type: :policy do
  let(:user) { create(:user) }
  let(:user_1) { create(:user) }

  let(:book) { create(:book, user: user) }

  describe "#update?" do
    context "when user owns the book" do
      let(:policy) { BookPolicy.new(user, book) }
      it "allows updating" do
        expect(policy.update?).to be(true)
      end
    end

    context "when user does not own the book" do
      let(:policy) { BookPolicy.new(user_1, book) }
      it "does not allow updating" do
        expect(policy.update?).to be(false)
      end
    end
  end

  describe "#destroy?" do
    context "when user owns the book" do
      let(:policy) { BookPolicy.new(user, book) }
      it "allows destroying" do
        expect(policy.destroy?).to be(true)
      end
    end

    context "when user does not own the book" do
      let(:policy) { BookPolicy.new(user_1, book) }
      it "does not allow destroying" do
        expect(policy.destroy?).to be(false)
      end
    end
  end
end
