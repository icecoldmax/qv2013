class QuizzesController < ApplicationController

def new
end

def create
  gon.videos = params[:quiz][:videos]
  render 'show'
end


end