class UniqueViewerPerViewing < ActiveRecord::Migration[6.0]
  def change
    add_index(:viewers, %i[user_id viewing_id], unique: true)
  end
end
