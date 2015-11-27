class AutomationBuild < ActiveRecord::Base
  attr_accessible :automation_job_id, :build_str, :full_name, :number, :start_time, :elapsed_time, :duration, :result, :building, :success_cases_count, :failed_cases_count
  belongs_to :automation_job

  def progress
    building == true ? ((elapsed_time.to_f / automation_job.avg_build_duration.to_f).round(2) * 100).to_int : 100
  end

  def green_percent
    return 0 if success_cases_count == 0
    ((success_cases_count.to_f / (success_cases_count + failed_cases_count).to_f).round(2) * 100).to_int
  end

  def url
    yaml = YAML.load(File.read(Rails.root.join('config','jenkins.yml')))[Rails.env]
    "#{yaml['server_url']}/job/#{automation_job.name}/#{number}"
  end
end
