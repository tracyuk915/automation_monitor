namespace :build do
  namespace :sidekiq do
    task :start => :environment do
      yaml = YAML.load(ERB.new(File.read('config/sidekiq.yml')).result)[Rails.env]
      pidfile = yaml['pidfile']
      logfile = yaml['logfile']
      exec "sidekiq -d -L #{logfile} -P #{pidfile} -i 1"
    end

    task :stop do
      yaml = YAML.load(ERB.new(File.read('config/sidekiq.yml')).result)[Rails.env]
      pidfile = yaml['pidfile']
      exec "sidekiqctl stop #{pidfile} 60"
    end
  end

  task :update => :environment do
    AutomationSet.all.each do |automation_set|
      automation_set.automation_jobs.each do |automation_job|
        UpdateBuildJob.perform_async(automation_job.id, automation_job.name)

        puts "*****************Scheduled Update Job for Automation Job #{automation_job.name}"
      end
    end
  end

  task :backfill => :environment do
    AutomationSet.all.each do |automation_set|
      automation_set.automation_jobs.each do |automation_job|
        BackfillBuildJob.perform_async(automation_job.id, automation_job.name)

        puts "*****************Scheduled Backfill Job for Automation Job #{automation_job.name}"
      end
    end
  end
end