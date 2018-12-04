class Admin::CategoriesController < ApplicationController

  def index
    @products = Category.order(id: :desc).all
  end

  def new
    @product = Category.new
  end

  def create
  end

end
