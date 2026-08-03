class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book
  before_action :set_review, only: %i[edit update destroy]

  def create
    @review = @book.reviews.build(review_params)
    @review.user = current_user
    @review.published = params[:published] == "true"

    authorize @review

    if @review.save
      redirect_to @book, notice: "Review saved."
    else
      render "books/show", status: :unprocessable_content
    end
  end

  def edit
    authorize @review
  end

  def update
    authorize @review

    @review.published = params[:published] == "true"

    if @review.update(review_params)
      redirect_to @book, notice: "Review updated."
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    authorize @review

    @review.destroy

    redirect_to @book, notice: "Review deleted."
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_review
    @review = @book.reviews.find(params[:id])
  end

  def review_params
    params.expect(review: [ :body ])
  end
end
