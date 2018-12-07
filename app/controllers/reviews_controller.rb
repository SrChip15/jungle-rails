class ReviewsController < ApplicationController

  def create
    @review = Review.new(review_params)
    @product = Product.find_by(id: params[:product_id])
    @review.user = current_user

    if @review.save
      redirect_to product_path(@product)
    else
      redirect_to product_path(@product)
    end
  end

  def destroy
    @product = Product.find_by(id: params[:product_id])
    @review = Review.find_by(id: params[:id])
    if current_user.id == @review.user_id
      @review.destroy
    end
    redirect_to product_path(@product)
  end

  private
    def review_params
      review = params.require(:review).permit(:description, :rating)
      review[:product_id] = params[:product_id]
      review
 end

end
