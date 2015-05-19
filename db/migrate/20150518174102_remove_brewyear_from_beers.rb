class RemoveBrewyearFromBeers < ActiveRecord::Migration
  def change
    remove_column :beers, :brewyear, :int
  end
end
