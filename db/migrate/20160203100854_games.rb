class Games < ActiveRecord::Migration
  def change
    create_table :games do |g|
      g.integer :player_1
      g.integer :player_2
      g.integer :winner
    end 
  end
end
