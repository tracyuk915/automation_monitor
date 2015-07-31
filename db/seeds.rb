# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

automation_set = AutomationSet.create(name: "Weibo Automation Set - Staging", description: "All Weibo Automation Jobs including SRMA, Publisher, Engage")
puts "=======================Created Set: #{automation_set.name}"

def create_job_build(automation_set, job_name)
  job = AutomationJob.create(name: job_name)
  puts "=======================Created Job: #{job.name}"

  automation_set.automation_jobs << job
end

create_job_build(automation_set, "Staging-Account-Automation-LI-SW")
create_job_build(automation_set, "Staging-Publish-Automation-LI-SW")
create_job_build(automation_set, "Staging-Engage-SW-Full-Tracy")