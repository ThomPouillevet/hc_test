class AddDateOfInteredConfirmationToRequest < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :date_of_interest_confirmation, :datetime
  end
end
