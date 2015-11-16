class AutomationSetController < ApplicationController

  def show
    @automation_set = AutomationSet.find(params[:id])
  end

  def index

  end
end
