class ApplicationController < ActionController::Base
    before_action :set_books

    private
  
    def set_books
      @books = Book.all
    end
end
