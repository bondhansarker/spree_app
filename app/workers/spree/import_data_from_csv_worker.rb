require 'csv'
module Spree
  class ImportDataFromCsvWorker
    include Sidekiq::Worker

    def perform(imported_file_id)
      imported_file = ImportedDocument.find imported_file_id
      file_path = ActiveStorage::Blob.service.send(:path_for, imported_file.document.blob.key)
      data = []
      CSV.foreach file_path, headers: true do |row|
        data << row.to_h
      end
      p data
    end
  end
end
