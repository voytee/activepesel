class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :mums_pesel
      t.string :dads_pesel

      t.timestamps
    end
  end
end
