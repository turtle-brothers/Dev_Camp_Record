class Api::ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :update, :destroy]

    # POST /articles
    def create
      @article = Article.new(article_params)
      @article.slug = @article.title.parameterize

      if @article.save
        render json: { article: @article }, status: :created
      else
        render json: @article.errors, status: :unprocessable_entity
      end
    end

    # GET /articles/:slug
    def show
      render json: { article: @article }
    end

    # PATCH/PUT /articles/:slug
    def update
      if @article.update(article_params)
        render json: { article: @article }
      else
        render json: @article.errors, status: :unprocessable_entity
      end
    end

    # DELETE /articles/:slug
    def destroy
      @article.destroy
    end

    private
      def set_article
        @article = Article.find_by_slug!(params[:slug])
      end

      def article_params
        params.require(:article).permit(:title, :description, :body)
      end
end
