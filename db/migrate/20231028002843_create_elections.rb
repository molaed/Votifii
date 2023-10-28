class CreateElections < ActiveRecord::Migration[7.0]
  def change
    create_table :elections do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
