require 'spec_helper'

describe SessionsController do

  describe "GET 'callback'" do
    it "returns http success" do
      get 'callback'
      response.should be_success
    end
  end

end
