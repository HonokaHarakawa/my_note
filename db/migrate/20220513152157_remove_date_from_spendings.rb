class RemoveDateFromSpendings < ActiveRecord::Migration[5.2]
  def change
    remove_column :spendings, :date, :date
  end
end
