require 'spec_helper'

describe "Static Pages" do
  
  describe "Home page" do
    
    it "should have the content 'QuizVids'" do
      visit '/static_pages/home'
      page.should have_selector('h1', :text => 'QuizVids')
    end

    it "should have the right title" do
      visit '/static_pages/home'
      page.should have_selector('title', :text => "QuizVids | Home")
    end
  end

  describe "Setup page" do
    it "should have the content 'Setup your quiz'" do
      visit '/static_pages/setup'
      page.should have_selector('h1', :text => 'Setup your quiz')
    end

    it "should have the right title" do
      visit '/static_pages/setup'
      page.should have_selector('title', :text => "QuizVids | Setup")
    end
  end

  describe "Quiz page" do

    it "should have the content 'Quiz Time!'" do
      visit '/static_pages/quiz'
      page.should have_selector('h1', :text => "Quiz Time!")
    end

    it "should have the right title" do
      visit '/static_pages/quiz'
      page.should have_selector('title', :text => "QuizVids | Quiz")
    end
  end

end
