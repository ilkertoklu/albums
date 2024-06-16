class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :username, null: false
      t.string :email, null: false
      t.string :phone, null: false
      t.string :website, null: false
      t.jsonb :address, default: {}, null: false
      t.jsonb :company, default: {}, null: false

      t.timestamps
    end

    add_index :users, :username, unique: true
    add_index :users, :email, unique: true
    add_index :users, :phone, unique: true
  end
end
