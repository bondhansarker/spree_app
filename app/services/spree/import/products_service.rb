module Spree
  module Import
    class ProductsService < BaseService
      attr_reader :imported_document

      def initialize(imported_document_id)
        @imported_document = ImportedDocument.find imported_document_id
      end

      def call
        extract_data_from_csv
      end

      private

      def imported_document_path
        ActiveStorage::Blob.service.send(:path_for, @imported_document.document.blob.key)
      end

      def extract_data_from_csv
        data = []
        CSV.foreach imported_document_path, headers: true do |row|
          data << row.to_h
        end
        p data
      end
    end
  end
end
