class CreateScripts < ActiveRecord::Migration
  def self.up
    create_table :scripts do |t|
      t.string :IP
      t.string :Port

      t.timestamps
    end
  end

  def self.down
    drop_table :scripts
  end
end
