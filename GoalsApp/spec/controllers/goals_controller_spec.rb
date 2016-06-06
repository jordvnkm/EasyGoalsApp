require 'rails_helper'
include AuthFeaturesHelper

begin
  GoalsController
rescue
  GoalsController = nil
end


RSpec.describe GoalsController, :type => :controller do
  let(:john) { User.create!(username: 'john_doe', password: 'abcdef') }

  describe "GET #new" do
   context "when logged in" do

     before do
       allow(controller).to receive(:current_user) { john }
     end

     it "renders the new links page" do
       get :new, post: {}
       expect(response).to render_template("new")
     end
   end

   context "when logged out" do
     before do
       allow(controller).to receive(:current_user) { nil }
     end

     it "redirects to the login page" do
       get :new, post: {}
       expect(response).to redirect_to(new_session_url)
     end
   end
 end

 describe "GET #index" do
   context "when logged out" do
     before do
       allow(controller).to receive(:current_user) { nil }
     end

     it "redirects to the login page" do
       get :index, post: {}
       expect(response).to redirect_to(new_session_url)
     end
   end
 end


 describe "PATCH #update" do
   context "when logged in as a different user" do
     create_goal_with_jill

     before do
       allow(controller).to receive(:current_user) { john }
     end

     it "should not allow users to update another users goals" do
       begin
         post :update, id: jill_goal, goal: {title: "Eat Cake", private_goal: false}
       rescue ActiveRecord::RecordNotFound
       end

       expect(jill_goal.title).to eq("Run 5 Miles")
     end
   end
 end

 describe "POST #create" do
   let(:john_doe) { User.create!(username: "john_doe", password: "abcdef") }

   before do
     allow(controller).to receive(:current_user) { john_doe }
   end

   context "with invalid params" do
     it "validates the presence of title" do
       post :create, goal: {title: "this is an invalid goal", private_goal: "invalid status"}
       expect(response).to render_template("new")
       expect(flash[:errors]).to be_present
     end
   end

   context "with valid params" do
     it "redirects to the goal show page" do
       post :create, goal: {title: "teehee", private_goal: true}
       expect(response).to redirect_to(goal_url(Goal.last))
     end
   end
 end
end
