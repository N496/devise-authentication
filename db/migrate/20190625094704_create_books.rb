class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :authors
      t.string :cover
      t.string :goodreadsId
      t.integer :pages
      t.string :preview_book
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
