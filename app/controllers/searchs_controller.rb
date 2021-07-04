class SearchsController < ApplicationController

  def search

    if params[:model] == "user"
      @users = User.search(params[:keyword])
    elsif params[:model] == "book"
      @books = Book.search(params[:keyword])
    else
    end

  end

end
