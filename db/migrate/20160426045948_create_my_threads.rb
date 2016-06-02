class CreateMyThreads < ActiveRecord::Migration
  def change
    create_table :my_threads do |t|
      t.string :title, null: false

      t.timestamps
    end
  end
end
