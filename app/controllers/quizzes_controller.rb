class QuizzesController < ApplicationController

def new
end

def create
  gon.videos = params[:quiz][:videos]
  gon.interval = params[:quiz][:interval].to_i
  gon.arithmetic = params[:quiz][:arithmetic]
  render 'show'
end


end