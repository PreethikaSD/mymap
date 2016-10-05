class AddConvertDateToStores < ActiveRecord::Migration[5.0]
  def change
  	add_column :stores, :convert_date, :integer
  end
end
