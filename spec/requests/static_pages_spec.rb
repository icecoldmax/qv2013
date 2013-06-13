require 'spec_helper'

describe "Static Pages" do

  subject { page }
  
  describe "Home page" do
    before { visit root_path }
    
    it { should have_selector('h1', :text => 'QuizVids') }
    it { should have_selector('title', :text => full_title('')) }
  end

  describe "Setup page" do
    before { visit setup_path }

    it { should have_selector('h1', :text => 'Setup your quiz') }
    it { should have_selector('title', :text => full_title('Setup')) }
  end

  describe "Quiz page" do
    before { visit quiz_path }
    
    it { should have_selector('h1', :text => "Quiz Time!") }
    it { should have_selector('title', :text => full_title('Quiz')) }    
  end

end
