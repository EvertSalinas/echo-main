namespace :migrate_sellers do
  task execute: :environment do
    Rails.logger.info 'Migrating sellers to admin user table'

    # Create new accounts
    Seller.all.each do |seller|
      user = AdminUser.create!(
        email: "#{seller.name.split[0]}@example.com",
        role: 'ventas',
        password: 'testing',
        password_confirmation: 'testing',
        name: seller.name
      )

      invoices = seller.invoices

      invoices.update_all(admin_user_id: user.id)
      # seller.destroy!
    end
  end
end
