class SubsController < ApplicationController
  before_action :redirect_unless_moderator_is_editing, only: [:edit, :update]
  
  def index
    @subs = Sub.all
    render :index
  end
  
  def show
    @sub = Sub.find(params[:id])
    @posts = @sub.posts
    render :show
  end
  
  def new
    @sub = Sub.new
    render :new
  end
  
  def create
    @sub = Sub.new(sub_params)
    @sub.moderator = current_user
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end
  
  def edit
    @sub = Sub.find(params[:id])
    @user = @sub.moderator
    render :edit
  end
  
  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end
  
  private
  
  def sub_params
    params.require(:sub).permit(:title, :description)
  end
  
  def redirect_unless_moderator_is_editing
    sub = Sub.find(params[:id])
    redirect_to sub_url(sub) unless current_user == sub.moderator
  end
end
