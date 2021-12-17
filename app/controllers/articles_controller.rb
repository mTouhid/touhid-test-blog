class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_logged_in, except: [:index, :show]
  before_action :require_the_author, only: [:edit, :destroy]

  def index
    @articles = Article.all
  end

  def show

  end

  def new
    @article = Article.new
  end

  def edit

  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    if @article.save
      flash[:success] = "Article was created successfully."
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    if @article.update(article_params)
      flash[:success] = "Article was successfully updated."
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def require_the_author
    if current_user != @article.user
      flash[:warning] = "You do not have permission to edit this article."
      redirect_to article_path
    end
  end
end