class CreateMoms < ActiveRecord::Migration
  def change
    create_table :moms do |t|
      t.string :name

      t.timestamps
    end
  end
end
