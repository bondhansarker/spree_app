class AddCustomFieldsToSpreeVariants < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_variants, :author, :string
    add_column :spree_variants, :url, :string
    add_column :spree_variants, :discounted_price, :string
  end
end
