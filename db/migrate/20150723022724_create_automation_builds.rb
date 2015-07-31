class CreateAutomationBuilds < ActiveRecord::Migration
  def change
    create_table :automation_builds do |t|
      t.integer :automation_job_id
      t.string :build_str
      t.string :number
      t.string :full_name
      t.time :start_time
      t.integer :elapsed_time
      t.integer :duration
      t.string :result
      t.boolean :building

      t.timestamps
    end
  end
end
