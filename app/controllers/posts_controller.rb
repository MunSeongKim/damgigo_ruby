class PostsController < ApplicationController
  # 다른 액션이 실행되기 전에 실행되는 액션을 지정
  # only: 어떤 액션에만 적용될지 지정
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # CanCanCan에서 :read, :create, :update, :destory 액션에 대해 컨트롤러 액션과 매핑 해놓음
  # 사전에 매핑된 액션을 컨트롤러에 자동 적용
  # Aliase action - ability.rb에서 action_aliase로 수정 가능
  # - :index, :show, :to => :read
  # - :new, :to => :create
  # - :edit, :to => :update
  # - :destory => :destory
  load_and_authorize_resource

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @email = User.find(Post.find(params[:id])[:user_id])[:email]
    
    # Method is relative Comment model
    @comments = Comment.all
    @comment = Comment.new
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post[:user_id] = current_user.id
    
    # begin
      respond_to do |format|
        if @post.save
          format.html { redirect_to @post, notice: 'Post was successfully created.' }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { render :new }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    # CanCanCan Gem에서 발생하는 접근제어 예외 처리
    # rescue CanCan::AccessDenied => exception
    #   respond_to do |format|
    #     format.json { head :forbidden, content_type: 'text/html' }
    #     format.html { redirect_to new_user_session_path, :alert => exception.message }
    #     format.js   { head :forbidden, content_type: 'text/html' }
    #   end
    # end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :desc, :content, :image)
    end
end
