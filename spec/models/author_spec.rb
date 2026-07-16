describe Author, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:first_name) }
  end
end
