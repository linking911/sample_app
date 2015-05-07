require 'rails_helper'

RSpec.describe "UserPages", :type => :request do
  describe "User pages" do
    subject {page}
    
    describe "signup page" do
      before { visit "/signup" }
      
      it { should have_content('Sign up') }
      it { should have_title(full_title('Sign up')) }
    end
  end
  
end
