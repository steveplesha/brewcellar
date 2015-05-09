class AddTypeToBeers < ActiveRecord::Migration
  def change
    add_column :beers, :beertype, :string
  end
end
