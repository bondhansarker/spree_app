# This migration comes from spree (originally 20191016134113)
class AddDeafultValueForStoreDefaultCurrency < ActiveRecord::Migration[5.2]
  def change
    Spree::Store.where(default_currency: nil).update_all(default_currency: Spree::Config[:currency])
  end
end
