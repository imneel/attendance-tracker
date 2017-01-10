unless Admin.where(email: 'admin@geniusu.com').exists?
  Admin.create!(email: 'admin@geniusu.com', password: 'G5n9u19U')
end