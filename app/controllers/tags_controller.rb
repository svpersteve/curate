class TagsController < ApplicationController
  load_and_authorize_resource
  before_action :find_tag, only: [:show]

  def index
    @tags = Tag.all
  end

  private

  def find_tag
    @tag = Tag.find(params[:id])
  end
end
