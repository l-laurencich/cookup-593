class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :location
      t.datetime :start
      t.datetime :end
      t.string :name
      t.text :description
      t.text :dietary_requirements
      t.string :menu
      t.float :price
      t.integer :capacity
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
