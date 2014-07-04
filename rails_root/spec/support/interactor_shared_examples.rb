require 'spec_helper'

shared_examples 'an interactor' do
  context "#initialize" do

    it "takes request data" do
      interactor = described_class.new(data: 1)
      expect(interactor.request).to eql(data: 1)
    end

  end
end
