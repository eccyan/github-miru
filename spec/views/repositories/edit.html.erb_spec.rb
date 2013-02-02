require 'spec_helper'

describe "repositories/edit" do
  before(:each) do
    @repository = assign(:repository, stub_model(Repository,
      :authentication_id => 1,
      :name => "MyString",
      :branch => "MyString",
      :head_sha => "MyString"
    ))
  end

  it "renders the edit repository form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => repositories_path(@repository), :method => "post" do
      assert_select "input#repository_authentication_id", :name => "repository[authentication_id]"
      assert_select "input#repository_name", :name => "repository[name]"
      assert_select "input#repository_branch", :name => "repository[branch]"
      assert_select "input#repository_head_sha", :name => "repository[head_sha]"
    end
  end
end
