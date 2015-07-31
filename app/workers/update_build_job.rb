require './lib/jenkins_client'

class UpdateBuildJob
  include Sidekiq::Worker
  def perform(job_id, job_name)
    client = JenkinsClient.new
    build = client.last_x_builds(job_name)[0]

    db_search = AutomationBuild.where(:automation_job_id => job_id, :number => build['number'])
    if db_search.count == 1 && db_search.first.building == false
      puts "===================Automation Build #{build['number']} of Job #{job_name} already DONE"
    else
      puts "===================Update Information for Automation Build #{build['number']} of Job #{job_name}"

      hash = client.build_details(job_name, build['number'])
      hash[:automation_job_id] = job_id

      if db_search.count == 0
        puts "===================+++++Created new DB Record for Automation Build #{build['number']} of Job #{job_name}"
        AutomationBuild.create(hash)
      else
        puts "===================+++++Updated DB Record for Automation Build #{build['number']} of Job #{job_name}"
        AutomationBuild.update(db_search.first.id, hash)
      end
    end

    schedule(job_id, job_name)
  end

  def schedule(job_id, job_name)
    UpdateBuildJob.perform_in(30.seconds, job_id, job_name)
  end
end