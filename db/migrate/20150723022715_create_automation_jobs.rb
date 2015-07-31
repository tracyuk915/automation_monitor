class CreateAutomationJobs < ActiveRecord::Migration
  def change
    create_table :automation_jobs do |t|
      t.string :name
      t.integer :avg_build_duration

      t.timestamps
    end
  end
end
