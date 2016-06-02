class CreateMyComments < ActiveRecord::Migration
  def change
    create_table :my_comments do |t|
      t.text :content
      t.references :my_thread, index: true

      t.timestamps
    end
  end
end
