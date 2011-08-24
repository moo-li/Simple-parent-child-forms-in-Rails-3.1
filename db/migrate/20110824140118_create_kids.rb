class CreateKids < ActiveRecord::Migration
  def change
    create_table :kids do |t|
      t.string :name
      t.references :mom

      t.timestamps
    end
    add_index :kids, :mom_id
  end
end
