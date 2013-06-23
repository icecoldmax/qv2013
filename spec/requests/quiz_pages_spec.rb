require 'spec_helper'

describe "QuizPages" do

  subject { page }

  describe "setup page" do
    before { visit setup_path }

    it { should have_selector('h1', text: "Setup" ) }
    it { should have_selector('title', text: "Setup" ) }

  end

end
