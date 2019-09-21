class CreateSlides < ActiveRecord::Migration[6.0]
  def change
    create_table :slides, id: :uuid do |t|
      t.string :title, null: false
      t.text :content
      t.references :slideshow, type: :uuid
      t.integer :ordinal, null: false
    end
    add_index :slides, [:ordinal, :slideshow_id]
  end
end
