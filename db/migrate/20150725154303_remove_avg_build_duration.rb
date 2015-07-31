class RemoveAvgBuildDuration < ActiveRecord::Migration
  def up
    remove_column :automation_jobs, :avg_build_duration
  end

  def down
    add_column :automation_jobs, :avg_build_duration, :integer
  end
end
