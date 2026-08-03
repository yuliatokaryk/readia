class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book
  before_action :set_review, only: %i[edit update destroy]

  def create
    @review = @book.reviews.build(review_params)

    authorize @review

    @review.user = current_user
    @review.published = params[:published] == "true"

    if @review.save
      redirect_to @book, notice: "Review saved."
    else
      @reviews = policy_scope(@book.reviews)
      render "books/show", status: :unprocessable_content
    end
  end

  def edit
    authorize @review

    @review.published = true if !@review.published?

    if @review.update(review_params)
      redirect_to @book
    else
      render :edit, status: :unprocessable_content
    end
  end

  def update
  end

  def destroy
    authorize @review

    @review.destroy

    redirect_to @book
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
