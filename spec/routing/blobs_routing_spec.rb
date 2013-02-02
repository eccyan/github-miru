require "spec_helper"

describe BlobsController do
  describe "routing" do

    it "routes to #index" do
      get("/blobs").should route_to("blobs#index")
    end

    it "routes to #new" do
      get("/blobs/new").should route_to("blobs#new")
    end

    it "routes to #show" do
      get("/blobs/1").should route_to("blobs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/blobs/1/edit").should route_to("blobs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/blobs").should route_to("blobs#create")
    end

    it "routes to #update" do
      put("/blobs/1").should route_to("blobs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/blobs/1").should route_to("blobs#destroy", :id => "1")
    end

  end
end
