class AddEnjoydateToBeers < ActiveRecord::Migration
  def change
    add_column :beers, :enjoydate, :string
    add_column :beers, :expirationdate, :string
  end
end
