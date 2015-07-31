class AddJoinTableSetJob < ActiveRecord::Migration
  def self.up
    create_table :automation_jobs_automation_sets, :id => false do |t|
      t.integer :automation_set_id
      t.integer :automation_job_id
    end
  end

  def self.down
    drop_table :automation_jobs_automation_sets
  end
end
