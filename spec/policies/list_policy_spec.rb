describe "ListPolicy", type: :policy do
  let(:user) { create(:user) }
  let(:user_1) { create(:user) }

  let(:list) { create(:list, user: user) }

  describe "#show?" do
    context "when user owns the list" do
      let(:policy) { ListPolicy.new(user, list) }
      it "allows updating" do
        expect(policy.show?).to be(true)
      end
    end

    context "when user does not own the list" do
      let(:policy) { ListPolicy.new(user_1, list) }
      it "does not allow updating" do
        expect(policy.show?).to be(false)
      end
    end
  end

  describe "#edit?" do
    context "when user owns the list" do
      let(:policy) { ListPolicy.new(user, list) }
      it "allows updating" do
        expect(policy.edit?).to be(true)
      end
    end

    context "when user does not own the list" do
      let(:policy) { ListPolicy.new(user_1, list) }
      it "does not allow updating" do
        expect(policy.edit?).to be(false)
      end
    end
  end

  describe "#update?" do
    context "when user owns the list" do
      let(:policy) { ListPolicy.new(user, list) }
      it "allows updating" do
        expect(policy.update?).to be(true)
      end
    end

    context "when user does not own the list" do
      let(:policy) { ListPolicy.new(user_1, list) }
      it "does not allow updating" do
        expect(policy.update?).to be(false)
      end
    end
  end

  describe "#destroy?" do
    context "when user owns the list" do
      let(:policy) { ListPolicy.new(user, list) }
      it "allows destroying" do
        expect(policy.destroy?).to be(true)
      end
    end

    context "when user does not own the list" do
      let(:policy) { ListPolicy.new(user_1, list) }
      it "does not allow destroying" do
        expect(policy.destroy?).to be(false)
      end
    end
  end
end
