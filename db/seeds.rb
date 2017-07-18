require 'factory_girl_rails'

# Default users
FactoryGirl.create :user, :with_posts, number_of_posts: rand(3..10),
                   name: 'Usuário Teste 1',
                   email: 'teste1@teste.com.br',
                   password: 'teste12345',
                   username: 'teste1'

FactoryGirl.create :user, :with_posts, number_of_posts: rand(3..10),
                   name: 'Usuário Teste 2',
                   email: 'teste2@teste.com.br',
                   password: 'teste12345',
                   username: 'teste2'

# Random users
8.times do
  FactoryGirl.create :user, :with_posts, number_of_posts: rand(3..10)
end
