class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.references :commenteable, polymorphic: true

      t.timestamps
    end
  end
end
