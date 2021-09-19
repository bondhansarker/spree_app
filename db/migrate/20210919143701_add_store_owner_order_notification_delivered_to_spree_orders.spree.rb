# This migration comes from spree (originally 20200607161221)
class AddStoreOwnerOrderNotificationDeliveredToSpreeOrders < ActiveRecord::Migration[5.2]
  def change
    unless column_exists?(:spree_orders, :store_owner_notification_delivered)
      add_column :spree_orders, :store_owner_notification_delivered, :boolean
    end
  end
end
