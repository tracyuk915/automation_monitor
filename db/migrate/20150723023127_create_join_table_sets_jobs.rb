class CreateJoinTableSetsJobs < ActiveRecord::Migration
  def up
    create_table :automation_set_job, id: false do |t|
      t.integer :set_id
      t.integer :job_id
    end
  end

  def down
    drop_table :automation_set_job
  end
end
