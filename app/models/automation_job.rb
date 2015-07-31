class AutomationJob < ActiveRecord::Base
  attr_accessible :name
  has_many :automation_builds
  has_and_belongs_to_many :automation_sets

  def avg_build_duration
    normal_jobs_duration = automation_builds.select{|x| !["ABORTED", "RUNNING"].include?(x.result) }.map(&:duration)
    normal_jobs_duration.inject{|sum,x| sum + x } / normal_jobs_duration.count
  end
end
