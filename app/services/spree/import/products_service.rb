require 'csv'
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
        rows ||= CSV.parse(File.read(imported_document_path), headers: true)
        rows.each do |title, author, original_price, discounted_price, url, image_url, summary, *properties|
          product = Spree::Product.where(name: get_value(title).titleize).first_or_create! do |product|
            product.stores = Spree::Store.all
            product.shipping_category = Spree::ShippingCategory.find_by!(name: 'Default')
            product.currency = "BDT"
            product.price = get_value(original_price)&.gsub(/[\s,TK.]/, "")
            product.description = get_value(summary)
            product.author = get_value(author)
            product.discounted_price = get_value(discounted_price)
            product.url = get_value(url)
          end
          properties.each do |attribute, value|
            product.set_property(get_property_key(attribute), value)
          end
        end
      end

      def get_property_key(attribute)
        attribute.gsub("_in_specification", "").titleize.to_sym if attribute.match?('_in_specification')
      end

      def get_value(column_with_header)
        column_with_header.last
      end
    end
  end
end
