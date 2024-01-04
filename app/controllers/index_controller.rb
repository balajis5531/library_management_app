class IndexController < ApplicationController
  
  def index
    @books = Book.all
    @recent_books = Book.order(created_at: :desc).limit(5)
  end

 
end
