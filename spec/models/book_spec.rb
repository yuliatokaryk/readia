describe Book, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:author).optional }
    it { is_expected.to belong_to(:list).optional }
  end
end
