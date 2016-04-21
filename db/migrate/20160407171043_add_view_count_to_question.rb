class AddViewCountToQuestion < ActiveRecord::Migration
  def change
    # you can find more info on method in here: http://edgeguides.rubyonrails.org/active_record_migrations.html
    # This migration adds a column named `view_count` to the `questions` table
    # the type of the column is integer
    add_column :questions, :view_count, :integer
  end
end
