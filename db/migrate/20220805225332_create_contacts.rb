class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.string :cell_number
      t.string :telephone_number
      t.string :email
      t.string :description

      t.belongs_to :owner, polymorphic: true, optional: true

      t.timestamps
    end
  end
end
