class AddAccessTypeShoeLacing < ActiveRecord::Migration
  def change
    change_table :roles do |t|
      t.boolean :shoe_lacing
    end
  end
end
