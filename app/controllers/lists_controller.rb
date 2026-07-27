class ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_list, only: %i[ show edit update destroy ]
  before_action :authorize_list, only: %i[show edit update destroy]

  def index
    @lists = policy_scope(List)
  end

  def show
  end

  def new
    @list = List.new
  end

  def edit
  end

  def create
    @list = List.new(list_params)
    @list.user = current_user

    if @list.save
      redirect_to @list, notice: "List was successfully created."
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @list.update(list_params)
      redirect_to @list, notice: "List was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @list.destroy!
    redirect_to lists_path, notice: "List was successfully destroyed.", status: :see_other
  end

  private
    def authorize_list
      authorize @list
    end

    def set_list
      @list = policy_scope(List).find(params.expect(:id))
    end

    def list_params
      params.expect(list: [ :name, :description ])
    end
end
