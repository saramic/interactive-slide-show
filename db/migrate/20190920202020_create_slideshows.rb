class CreateSlideshows < ActiveRecord::Migration[6.0]
  def change
    create_table :slideshows, id: :uuid do |t|
      t.string :title, null: false
      t.references :user, index: true, null: false, type: :uuid

      t.timestamps
    end
  end
end
