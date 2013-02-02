require 'spec_helper'

describe "repositories/index" do
  before(:each) do
    assign(:repositories, [
      stub_model(Repository,
        :authentication_id => 1,
        :name => "Name",
        :branch => "Branch",
        :head_sha => "Head Sha"
      ),
      stub_model(Repository,
        :authentication_id => 1,
        :name => "Name",
        :branch => "Branch",
        :head_sha => "Head Sha"
      )
    ])
  end

  it "renders a list of repositories" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Branch".to_s, :count => 2
    assert_select "tr>td", :text => "Head Sha".to_s, :count => 2
  end
end
