class AutomationSetController < ApplicationController

  def show
    @automation_set = AutomationSet.find(params[:id])
  end

  def index
    @automation_sets = AutomationSet.all
  end

  def new

  end

  def edit

  end
end
