require 'spec_helper'

describe "Static Pages" do
  
  describe "Home page" do
    
    it "should have the H1 'QuizVids'" do
      visit '/static_pages/home'
      page.should have_selector('h1', :text => 'QuizVids')
    end

    it "should have the base title" do
      visit '/static_pages/home'
      page.should have_selector('title', :text => "QuizVids")
    end

    it "should not have a custom page title" do
      visit '/static_pages/home'
      page.should_not have_selector('title', :text => '| Home')
    end
  end

  describe "Setup page" do
    it "should have the H1 'Setup your quiz'" do
      visit '/static_pages/setup'
      page.should have_selector('h1', :text => 'Setup your quiz')
    end

    it "should have the base title" do
      visit '/static_pages/setup'
      page.should have_selector('title', :text => "QuizVids")
    end
  end

  describe "Quiz page" do

    it "should have the H1 'Quiz Time!'" do
      visit '/static_pages/quiz'
      page.should have_selector('h1', :text => "Quiz Time!")
    end

    it "should have the base title" do
      visit '/static_pages/quiz'
      page.should have_selector('title', :text => "QuizVids")
    end
  end

end
