class PostsController < ApplicationController
  before_action :redirect_unless_post_belongs_to_current_user, only: [:edit, :update]
  before_action :redirect_if_not_logged_in, only: [:new, :create]
  
  def new
    @post = Post.new
    @subs = Sub.all
    render :new
  end
  
  def create
    @post = Post.new(post_params)
    @subs = Sub.all
    @post.author = current_user
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end
  
  def edit
    @post = Post.find(params[:id])
    @subs = Sub.all
    render :edit
  end
  
  def update
    @post = Post.find(params[:id])
    @post.sub_ids = post_params[:sub_ids]
    @subs = Sub.all
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end
  
  def upvote
    @post = Post.find(params[:post_id])
    @post.votes.create(value: 1, voter: current_user )
    redirect_to post_url(@post)
  end
  
  def downvote
    @post = Post.find(params[:post_id])
    @post.votes.create(value: -1, voter: current_user )
    redirect_to post_url(@post)
  end
  
  def show
    @post = Post.find(params[:id])
    @subs = @post.subs
    @all_comments = @post.comments_by_parent_id
    render :show
  end

  private
  
  def post_params
    params.require(:post).permit(:title, :content, :url, sub_ids: [] )
  end
  
  def redirect_unless_post_belongs_to_current_user
    post = Post.find(params[:id])
    redirect_to user_url(current_user) unless post.author == current_user
  end
end
