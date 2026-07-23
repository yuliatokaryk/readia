describe Author, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:books) }
  end
  describe "validations" do
    it { is_expected.to validate_presence_of(:first_name) }
  end

  describe "#full_name" do
    it "returns the author's full name" do
      author = create(
        :author,
        first_name: "Joanne",
        last_name: "Rowling"
      )

      expect(author.full_name).to eq("Joanne Rowling")
    end
  end
end
