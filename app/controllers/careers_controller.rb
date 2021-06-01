class CareersController < ApplicationController
  before_action :set_career, only: %i[ show edit update destroy send_email ]
  before_action :set_pages, only: %i[ index ]

  # GET /careers or /careers.json
  def index
    @show_all = true if params[:show_all]
    @careers = if params[:show_all]
                Career.order('created_at DESC')
              else
                Career.order('created_at DESC').limit(10).offset(@page * 10)
              end
  end

  # GET /careers/1 or /careers/1.json
  def show
    @comment = Comment.new
    @commenteable_type = 'Career'
    @commenteable_id = @career.id
  end

  # GET /careers/new
  def new
    @career = Career.new
  end

  # GET /careers/1/edit
  def edit
  end

  # POST /careers or /careers.json
  def create
    @career = Career.new(career_params)

    respond_to do |format|
      if @career.save
        format.html { redirect_to @career, notice: "Career was successfully created." }
        format.json { render :show, status: :created, location: @career }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @career.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /careers/1 or /careers/1.json
  def update
    respond_to do |format|
      if @career.update(career_params)
        format.html { redirect_to @career, notice: "Career was successfully updated." }
        format.json { render :show, status: :ok, location: @career }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @career.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /careers/1 or /careers/1.json
  def destroy
    @career.destroy
    respond_to do |format|
      format.html { redirect_to careers_url, notice: "Career was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def send_email
    email = params[:email].blank? ? 'haefeli.matthias@gmail.com' : params[:email]
    CmdMailer.with(cmds: @career, email: email).send_cmd.deliver_later
    redirect_to careers_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_career
      @career = Career.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def career_params
      params.require(:career).permit(:title, :body)
    end

    def set_pages
      @page ||= params[:page].to_i || 0
    end
end
