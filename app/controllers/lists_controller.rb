class ListsController < ApplicationController
  before_action :set_list, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[ create update destroy new edit index ]
  before_action :user_authenticated, only: %i[ create update destroy new edit index ]
  before_action :set_pages, only: %i[ index ]

  # GET /lists or /lists.json
  def index
    search_value = params[:search]
    @show_all = true if params[:show_all]
    @lists = if params[:show_all]
               List.order('created_at DESC')
             elsif
               search_value
               List.where('lower(title) like ?', "%#{search_value.downcase}%")
             else
               List.order('created_at DESC').limit(10).offset(@page * 10)
             end
  end

  # GET /lists/1 or /lists/1.json
  def show
    @comment = Comment.new
    @commenteable_type = 'List'
    @commenteable_id = @list.id
  end

  # GET /lists/new
  def new
    @list = List.new
  end

  # GET /lists/1/edit
  def edit
  end

  # POST /lists or /lists.json
  def create
    @list = List.new(list_params)

    respond_to do |format|
      if @list.save
        format.html { redirect_to @list, notice: "List was successfully created." }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lists/1 or /lists/1.json
  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to @list, notice: "List was successfully updated." }
        format.json { render :show, status: :ok, location: @list }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1 or /lists/1.json
  def destroy
    @list.destroy
    respond_to do |format|
      format.html { redirect_to lists_url, notice: "List was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def list_params
      params.require(:list).permit(:title, :link, :body)
    end

    def set_pages
      @page ||= params[:page].to_i || 0
    end
end
