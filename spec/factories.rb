FactoryBot.define do

  factory :wallet do
  end

  factory :transaction do
    pokemon { FactoryBot.create(:pokemon) }
    value { 0.01 }
    amount { 1 }

    trait :buy do
      operation { 'buy' }
    end

    trait :sell do
      operation { 'sell' }
    end
  end

  factory :pokemon do
    name { Faker::Games::Pokemon.name }
    base_experience { 100 }
    sprite { Faker::Internet.url }
  end

  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
