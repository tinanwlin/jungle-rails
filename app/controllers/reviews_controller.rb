class ReviewsController < ApplicationController

  def create  
    @product = Product.find params[:product_id]  
    @review = Review.new(review_params)
    @review.product_id = @product.id
    @review.user_id = current_user.id
    if @review.save
      redirect_to product_path(@product), notice: 'Thank you for reviewing!'
    else
      redirect_to product_path(@product)
    end
    
  end

  def destroy 
     Review.destroy(params[:id])
     redirect_to product_path(params[:product_id])
  end 

  private

  def review_params
    params.require(:review).permit(
      :description,
      :rating
    )
  end

end
