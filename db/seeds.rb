# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

AdminUser::ROLES.each do |role|
  AdminUser.create!(
    email: "admin+#{role}@example.com",
    role: role,
    password: 'testing',
    password_confirmation: 'testing',
    prefix: role.slice(0,2)
  )
end

cliente = Client.create(
  name: Faker::Name.name
)

vendedor = Seller.create(
  name: Faker::Name.name
)

Invoice.create!(
  total_amount_cents: 2353,
  condition: 'credito',
  system_date: 2.week.ago,
  physical_date: 1.week.ago,
  system_folio: 'E52256',
  physical_folio: '1-O',
  place: 'GUADALUPE, NUEVO LEON',
  status: 'pendiente',
  client: Client.first,
  seller: Seller.first
)

Invoice.create!(
  total_amount_cents: 54332,
  condition: 'credito',
  system_date: 2.week.ago,
  physical_date: 1.week.ago,
  system_folio: 'E52756',
  physical_folio: '2-0',
  place: 'GUADALUPE, NUEVO LEON',
  status: 'pendiente',
  client: Client.first,
  seller: Seller.first
)

Invoice.create!(
  total_amount_cents: 851,
  condition: 'credito',
  system_date: 2.week.ago,
  physical_date: 1.week.ago,
  system_folio: 'E524312',
  physical_folio: '3-O',
  place: 'GUADALUPE, NUEVO LEON',
  status: 'pendiente',
  client: Client.first,
  seller: Seller.first
)

# Payment.create!(
#   cantidad_total:
# )
