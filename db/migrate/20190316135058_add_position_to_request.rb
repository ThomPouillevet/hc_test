class AddPositionToRequest < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :position, :integer
  end
end
