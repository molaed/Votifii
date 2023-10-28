class CreateCandidates < ActiveRecord::Migration[7.0]
  def change
    create_table :candidates do |t|
      t.string :name
      t.text :description
      t.integer :voteCount
      t.references :election, null: false, foreign_key: true

      t.timestamps
    end
  end
end
