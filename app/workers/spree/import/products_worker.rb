module Spree
  module Import
    class ProductsWorker
      include Sidekiq::Worker
      sidekiq_options max_retries: 5

      def perform(imported_document_id)
        Import::ProductsService.call(imported_document_id)
      end
    end
  end
end
