require 'spec_helper'

describe "Static pages" do
  
  subject { page }
  
  describe "Home page" do
    
    before { visit root_path }
    
    it { should have_content('Sample App') }
    it { should have_title(full_title('')) }
    it { should_not have_title('| Home') }
    
    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        
        sign_in user
        visit root_path
      end
      
      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end
    end
    
  end
  
  describe "Help page" do
    it "should have the content 'Help'" do
      #visit "/static_pages/help"
      visit "/help"
      expect(page).to have_content("Help")
    end
    
    it "should have the title 'Help'" do
      #visit "/static_pages/help"
      visit "/help"
      expect(page).to have_title(full_title('Help'))
    end
  end
  
  describe "About page" do
    it "should have the content 'About Us'" do
      #visit "/static_pages/about"
      visit "/about"
      expect(page).to have_content("About Us")
    end
    
    it "should have the title 'About'" do
      #visit "/static_pages/about"
      visit "/about"
      expect(page).to have_title(full_title('About'))
    end
  end
  
  describe "Contact Us" do
    it "should have the content 'Contact Us'" do
      #visit "/static_pages/contact"
      visit "/contact"
      expect(page).to have_content("Contact Us")
    end
    
    it "should have the title 'Contact'" do
      #visit "/static_pages/contact"
      visit "/contact"
      expect(page).to have_title(full_title("Contact"))
    end 
  end
  
end
