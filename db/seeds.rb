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
    password: 'cruzazul2020',
    password_confirmation: 'cruzazul2020'
  )
end

cliente = Client.create(
  nombre: Faker::Name.name
)

vendedor = Seller.create(
  nombre: Faker::Name.name
)

Invoice.create!(
  cantidad_total: 23.53,
  condicion: 'credito',
  fecha_factura: 2.week.ago,
  fecha_remision: 1.week.ago,
  folio_remision_factura: '1-O',
  folio_remision_fisica: 'E52256',
  lugar: 'GUADALUPE, NUEVO LEON',
  estatus: 'pendiente',
  client: Client.first,
  seller: Seller.first
)

Invoice.create!(
  cantidad_total: 543.32,
  condicion: 'credito',
  fecha_factura: 2.week.ago,
  fecha_remision: 1.week.ago,
  folio_remision_factura: '2-0',
  folio_remision_fisica: 'E43134',
  lugar: 'GUADALUPE, NUEVO LEON',
  estatus: 'pendiente',
  client: Client.first,
  seller: Seller.first
)

Invoice.create!(
  cantidad_total: 85.1,
  condicion: 'credito',
  fecha_factura: 2.week.ago,
  fecha_remision: 1.week.ago,
  folio_remision_factura: '3-O',
  folio_remision_fisica: 'E524312',
  lugar: 'GUADALUPE, NUEVO LEON',
  estatus: 'pagada',
  client: Client.first,
  seller: Seller.first
)

# Payment.create!(
#   cantidad_total:
# )
