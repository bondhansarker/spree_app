module Spree
  class ImportedDocument < Spree::Base
    has_one_attached :document
    validates :name, :note, :document, presence: true
    validates :document, content_type:  ["application/csv", "text/csv"]
  end
end
