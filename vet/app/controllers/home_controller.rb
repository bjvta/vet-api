class HomeController < ApplicationController
  def index
    render json: [{"message": "Hello World from API"}]
  end
end
