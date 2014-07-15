class QueriesController < ApplicationController
  before_action :set_query, only: [:show, :edit, :update, :destroy]

  def index
    @queries = Query.all
  end

  def show
  end

  def new
    @query = Query.new
  end

  def edit
  end

  def create
    @query = Query.new(query_params)

    respond_to do |format|
      if @query.save
        format.html { redirect_to @query, notice: 'Query was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @query.update(query_params)
        format.html { redirect_to @query, notice: 'Query was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @query.destroy
    respond_to do |format|
      format.html { redirect_to queries_url, notice: 'Query was successfully destroyed.' }
    end
  end

  private

  def set_query
    @query = Query.find(params[:id])
  end

  def query_params
    params.require(:query).permit(:username)
  end
end
