class AddProfileImageToCandidates < ActiveRecord::Migration[7.0]
  def change
    add_column :candidates, :profile_image, :string
  end
end
