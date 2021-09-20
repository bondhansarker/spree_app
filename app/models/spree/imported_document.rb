module Spree
  class ImportedDocument < Spree::Base
    has_one_attached :document
    validates :name, :note, :document, presence: true
    validates :document, content_type:  ["application/csv", "text/csv"]
    after_save_commit :import_data_from_csv

    def import_data_from_csv
       ImportDataFromCsvWorker.perform_async(self.id)
    end
  end
end
