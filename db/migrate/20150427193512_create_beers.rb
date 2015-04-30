class CreateBeers < ActiveRecord::Migration
  def change
    create_table :beers do |t|
      t.string :name
      t.string :brewery
      t.integer :brewyear
      t.string :size
      t.integer :quantity

      t.timestamps
    end
  end
end
