require 'spec_helper'

describe "blobs/edit" do
  before(:each) do
    @blob = assign(:blob, stub_model(Blob,
      :authentication_id => 1,
      :branch => "MyString",
      :head_sha => "MyString",
      :repository_name => "MyString",
      :path => "MyString"
    ))
  end

  it "renders the edit blob form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => blobs_path(@blob), :method => "post" do
      assert_select "input#blob_authentication_id", :name => "blob[authentication_id]"
      assert_select "input#blob_branch", :name => "blob[branch]"
      assert_select "input#blob_head_sha", :name => "blob[head_sha]"
      assert_select "input#blob_repository_name", :name => "blob[repository_name]"
      assert_select "input#blob_path", :name => "blob[path]"
    end
  end
end
