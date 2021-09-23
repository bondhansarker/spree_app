module Spree
  class ImportedDocument < Spree::Base
    has_one_attached :document
    validates :name, :note, :document, presence: true
    validates :document, content_type:  %w[application/csv text/csv]
    after_save :import_products_from_csv_file

    def import_products_from_csv_file
       Import::ProductsWorker.perform_async(self.id)
    end
  end
end
