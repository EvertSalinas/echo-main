namespace :migrate_sellers do
  task execute: :environment do
    Rails.logger.info 'Migrating sellers to admin user table'

    # Create new accounts
    Seller.all.each do |seller|
      email_add = "#{seller.name.split[0]}@example.com".downcase
      if AdminUser.exists?(email: email_add)
        user = AdminUser.find_by(email: email_add)
      else
        user = AdminUser.create!(
          email: email_add,
          role: 'ventas',
          password: 'testing',
          password_confirmation: 'testing',
          name: seller.name
        )
      end
      binding.pry
      invoices = seller.invoices
      payments = seller.payments

      invoices.update_all(admin_user_id: user.id)
      payments.update_all(seller_id: user.id)
      # seller.destroy!
    end
  end
end
