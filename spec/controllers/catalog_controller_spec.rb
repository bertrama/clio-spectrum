require 'spec_helper'

describe CatalogController do

  describe "GET 'endnote.endnote'" do

        it "should work for single ids" do 
    #     {"id"=>["323033", "5417238"], "controller"=>"catalog", "action"=>"endnote", "format"=>"endnote", "adv"=>{}}
          get 'endnote', format: 'endnote', id: "100"
          response.should be_success
        end

    it "should work for multiple ids" do 
#     {"id"=>["323033", "5417238"], "controller"=>"catalog", "action"=>"endnote", "format"=>"endnote", "adv"=>{}}
      get 'endnote', format: 'endnote', id: ["123", "1234"]
      response.should be_success
    end

  end

end

