require 'spec_helper'

describe "blobs/new" do
  before(:each) do
    assign(:blob, stub_model(Blob,
      :authentication_id => 1,
      :branch => "MyString",
      :head_sha => "MyString",
      :repository_name => "MyString",
      :path => "MyString"
    ).as_new_record)
  end

  it "renders new blob form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => blobs_path, :method => "post" do
      assert_select "input#blob_authentication_id", :name => "blob[authentication_id]"
      assert_select "input#blob_branch", :name => "blob[branch]"
      assert_select "input#blob_head_sha", :name => "blob[head_sha]"
      assert_select "input#blob_repository_name", :name => "blob[repository_name]"
      assert_select "input#blob_path", :name => "blob[path]"
    end
  end
end
