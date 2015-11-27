require './lib/jenkins_client'

class AutomationJobController < ApplicationController

  def new

    client = JenkinsClient.new
    
    p "trigger single job names: #{job.name}"
    client.kick_build(params[:name])

    respond_to do |format|
      format.html
      format.json
    end

  end

end
