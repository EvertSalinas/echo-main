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

Remission.create(
  cantidad_total_cents: 1000,
  condicion: 'CREDITO',
  fecha_factura: 2.week.ago,
  fecha_remision: 1.week.ago,
  folio_remision_factura: '1-O',
  folio_remision_fisica: 'E52256',
  lugar: 'GUADALUPE, NUEVO LEON',
  status: 'pendiente',
  client: cliente,
  seller: vendedor
)

Remission.create(
  cantidad_total_cents: 1000,
  condicion: 'CREDITO',
  fecha_factura: 2.week.ago,
  fecha_remision: 1.week.ago,
  folio_remision_factura: '1-O',
  folio_remision_fisica: 'E52256',
  lugar: 'GUADALUPE, NUEVO LEON',
  status: 'pendiente',
  client: cliente,
  seller: vendedor
)

Remission.create(
  cantidad_total_cents: 1000,
  condicion: 'CREDITO',
  fecha_factura: 2.week.ago,
  fecha_remision: 1.week.ago,
  folio_remision_factura: '1-O',
  folio_remision_fisica: 'E52256',
  lugar: 'GUADALUPE, NUEVO LEON',
  status: 'pagada',
  client: cliente,
  seller: vendedor
)
