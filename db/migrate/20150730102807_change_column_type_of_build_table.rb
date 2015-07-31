class ChangeColumnTypeOfBuildTable < ActiveRecord::Migration
  def up
    change_column :automation_builds, :start_time, :datetime
  end

  def down
    change_column :automation_builds, :start_time, :time
  end
end
