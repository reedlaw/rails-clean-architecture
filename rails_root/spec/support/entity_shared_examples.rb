shared_examples 'an entity' do
  context "#initialize" do
    it "can have id assigned" do
      entity = described_class.new(id: 1)
      expect(entity.id).to eql(1)
    end
    it "can't have non-accessible attributes assigned" do
      expect { described_class.new(non_attrib: true) }.to raise_error
    end
  end
end
