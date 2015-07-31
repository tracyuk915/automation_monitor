class DropAutomationJobSet < ActiveRecord::Migration
  def up
    drop_table :automation_set_job
  end

  def down
    create_table :automation_set_job, id: false do |t|
      t.integer :set_id
      t.integer :job_id
    end
  end
end
