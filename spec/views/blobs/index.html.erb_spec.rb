require 'spec_helper'

describe "blobs/index" do
  before(:each) do
    assign(:blobs, [
      stub_model(Blob,
        :authentication_id => 1,
        :branch => "Branch",
        :head_sha => "Head Sha",
        :repository_name => "Repository Name",
        :path => "Path"
      ),
      stub_model(Blob,
        :authentication_id => 1,
        :branch => "Branch",
        :head_sha => "Head Sha",
        :repository_name => "Repository Name",
        :path => "Path"
      )
    ])
  end

  it "renders a list of blobs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Branch".to_s, :count => 2
    assert_select "tr>td", :text => "Head Sha".to_s, :count => 2
    assert_select "tr>td", :text => "Repository Name".to_s, :count => 2
    assert_select "tr>td", :text => "Path".to_s, :count => 2
  end
end
