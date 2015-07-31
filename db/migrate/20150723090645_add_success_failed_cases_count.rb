class AddSuccessFailedCasesCount < ActiveRecord::Migration
  def up
    add_column :automation_builds, :success_cases_count, :integer, :default => 0
    add_column :automation_builds, :failed_cases_count, :integer, :default => 0
  end

  def down
    remove_column :automation_builds, :success_cases_count
    remove_column :automation_builds, :failed_cases_count
  end
end
