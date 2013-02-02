require 'spec_helper'

describe "repositories/show" do
  before(:each) do
    @repository = assign(:repository, stub_model(Repository,
      :authentication_id => 1,
      :name => "Name",
      :branch => "Branch",
      :head_sha => "Head Sha"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Name/)
    rendered.should match(/Branch/)
    rendered.should match(/Head Sha/)
  end
end
