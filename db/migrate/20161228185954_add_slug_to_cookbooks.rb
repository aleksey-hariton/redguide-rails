class AddSlugToCookbooks < ActiveRecord::Migration[5.0]
  def change
    add_column :cookbooks, :slug, :string
  end
end
