class AddImageLinkToCandidates < ActiveRecord::Migration[7.0]
  def change
    add_column :candidates, :image_link, :string
  end
end
