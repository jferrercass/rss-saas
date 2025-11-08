org = Organization.create!(name: 'Acme')
org.users.create!(email: 'admin@acme.local', password: 'password', role: :admin)
org.api_keys.create!(scopes: ['read'])