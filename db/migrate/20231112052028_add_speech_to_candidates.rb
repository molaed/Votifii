class AddSpeechToCandidates < ActiveRecord::Migration[7.0]
  def change
    add_column :candidates, :speech, :text
  end
end
