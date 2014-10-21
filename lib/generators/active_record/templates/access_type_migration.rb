class AddAccessType<%= singular_name.camelize %> < ActiveRecord::Migration
  def change
    change_table :roles do |t|
      t.boolean :<%= singular_name %>
    end
  end
end
