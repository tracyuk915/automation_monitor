require './lib/jenkins_client'

class BackfillBuildJob
  include Sidekiq::Worker

  def perform(job_id, job_name)
    if AutomationJob.find_by_name(job_name).automation_builds.count < 10
      client = JenkinsClient.new
      client.last_x_builds(job_name, 10).each do |build|
        puts "===================Update Information for Automation Build #{build['number']} of Job #{job_name}"

        hash = JenkinsClient.new.build_details(job_name, build['number'])
        hash[:automation_job_id] = job_id
        AutomationBuild.create(hash)
      end
    end
  end
end