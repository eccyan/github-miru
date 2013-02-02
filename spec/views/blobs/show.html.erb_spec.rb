require 'spec_helper'

describe "blobs/show" do
  before(:each) do
    @blob = assign(:blob, stub_model(Blob,
      :authentication_id => 1,
      :branch => "Branch",
      :head_sha => "Head Sha",
      :repository_name => "Repository Name",
      :path => "Path"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Branch/)
    rendered.should match(/Head Sha/)
    rendered.should match(/Repository Name/)
    rendered.should match(/Path/)
  end
end
