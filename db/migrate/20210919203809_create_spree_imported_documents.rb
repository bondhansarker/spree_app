class CreateSpreeImportedDocuments < ActiveRecord::Migration[6.1]
  def change
    create_table :spree_imported_documents do |t|
      t.string     :name, null: false
      t.text       :note, size: :long
      t.timestamps
    end
  end
end
