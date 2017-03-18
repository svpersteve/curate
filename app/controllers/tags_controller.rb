class TagsController < ApplicationController
  load_and_authorize_resource
  before_action :find_tag, only: [:show]

  def index
    @tags = Tag.all
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    @tag.creator = current_user

    respond_to do |format|
      if @tag.save
        format.html { redirect_to @tag, notice: "We've added your tag to the list." }
      else
        format.html { render :new, notice: "Sorry, there was an issue creating the #{@tag.name} tag." }
      end
    end
  end

  def update
    if @tag.update(tag_params)
      respond_to do |format|
        format.html { redirect_to @tag, notice: "We've updated the #{@tag.name} tag." }
      end
    else
      respond_to do |format|
        format.html { render :edit, notice: "Sorry, there was an issue updating the #{@tag.name} tag." }
      end
    end
  end

  def destroy
    @tag.destroy
    respond_to do |format|
      format.html { redirect_to tags_path }
    end
  end

  private

  def find_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params[:tag].permit(:name, :description)
  end
end
