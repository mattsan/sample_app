require 'spec_helper'

describe "Static pages" do

  let(:base_title) { "Ruby on Rails Tutorial Sample App" }
  before { visit root_path }

  subject { page }

  describe "Home page" do
    it "should have the h1 'Sample App'" do
      page.should have_selector('h1', :text => 'Sample App')
    end

    it "should have the title 'Home'" do
      page.should have_selector('title', :text => "#{base_title}")
    end

    it "should not have a custon page title" do
      page.should_not have_selector('title', :text => '| Home')
    end

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
          page.should have_selector("li##{item.id}", text: item.content)
        end
      end

      describe "follower/following counts" do
        let(:other_user) { FactoryGirl.create(:user) }
        before do
          other_user.follow!(user)
          visit root_path
        end

        it { should have_link("0 following", href: following_user_path(user)) }
        it { should have_link("1 followers", href: followers_user_path(user)) }
      end
    end
  end


  describe "Help page" do
  	it "should have the h1 'Help'" do
  	  visit help_path
  	  page.should have_selector('h1', :ttle => 'Help')
  	end

    it "should have the title 'Help'" do
      visit help_path
      page.should have_selector('title', :text => "#{base_title} | Help")
    end
  end

  describe "About page" do
    it "should have the h1 'About us'" do
      visit about_path
      page.should have_selector('h1', :text => 'About Us')
    end

    it "should have the title 'Aoubt Up'" do
      visit about_path
      page.should have_selector('title', :text => "#{base_title} | About Us")
    end
  end

  describe "Contact" do
    it "should have the h1 'Contact'" do
      visit contact_path
      page.should have_selector('h1', :text => "Contact")
    end

    it "should hove the title 'Contact'" do
      visit contact_path
      page.should have_selector('title', :text => "#{base_title} | Contact")
    end
  end
end
