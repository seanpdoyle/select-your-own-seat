FactoryBot.define do
  factory :benedum_center, class: "Venue" do
    name { "Benedum Center" }
    slug { "benedum_center" }
  end

  factory :floor do
    association :venue, factory: [:benedum_center]

    factory :balcony do
      name { "Balcony" }
      slug { "balcony" }
    end

    factory :orchestra do
      name { "Orchestra" }
      slug { "orchestra" }
    end
  end

  factory :section do
    association :floor, factory: [:orchestra]

    name { "Section #{id}" }
    slug { "section-#{id}" }
    price { 10_00 }
  end

  factory :cart do
  end

  factory :seat do
    association :section

    sequence(:number)
    row { "AA" }
    x { 0 }
    y { 0 }
  end

  factory :seat_selection do
    association(:cart)
    association(:seat)
  end
end
