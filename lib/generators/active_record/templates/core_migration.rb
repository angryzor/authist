class CreateAuthisticBehaviour < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.string :description
    end

    create_table :role_subscriptions do |t|
      t.references :role, index: true
      t.references :authorizable, index: { name: 'index_role_subs_on_auth_id_and_auth_type_authist' }, polymorphic: true
    end

    create_table :roles_roles do |t|
      t.references :role, index: true
      t.references :includer, index: true
    end
  end
end
