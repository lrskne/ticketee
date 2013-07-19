require 'spec_helper'

# book introduces the concept of 'context'.This will run either
# before each example or just once, not sure but since the context says
# just do , this assumes just once . A before (each) would run before each
# example
describe ProjectsController do
  let(:user) { Factory(:confirmed_user) }
  let(:project) { mock_model(Project, :id => 1) }
  
  context "standard users" do
    before do
      sign_in(:user, user)
    end
    
      ## This code was in there to just make it simple and test the new action
      ## in the controller: (so up to Listing 7.3)
      ##it "cannot access the new action" do
      ##get :new
      ##response.should redirect_to('/')
      ##flash[:alert].should == "You must be an admin to do that."
    it "cannot access the new action" do
      { :new => :get,
        :create => :post,
        :edit => :get,
        :update => :put,
        :destroy => :delete }.each do |action, method|
      it "cannot access the #{action} action" do
        sign_in(:user, user)
        send(method, action, :id => project.id)
        response.should redirect_to(root_path)
        flash[:alert].should eql("You must be an admin to do that.")
      end
        end
    end
  end
  
  it "displays an error for a missing project" do
      get :show, :id => "not-here"
      response.should redirect_to(projects_path)
      message = "The project you were looking for could not be found."
      flash[:alert].should == message
  end
end



# old code prior to step 7.2.1
#describe ProjectsController do
#  it "displays an error for a missing project" do
#      get :show, :id => "not-here"
#      response.should redirect_to(projects_path)
#      message = "The project you were looking for could not be found."
#      flash[:alert].should == message
#  end
#end
