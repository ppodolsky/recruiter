class DictionariesController < ApplicationController
  before_action :authenticate_user!
  before_action :raise_if_not_admin

  def index
    render 'index'
  end
  def show
    @name = params[:id].capitalize
    @dictionary = Object.const_get(@name).all
    render 'index'
  end
  def update

  end
end
