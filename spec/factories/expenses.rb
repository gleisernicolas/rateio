FactoryBot.define do
  factory :expense do
    title 'Futebol de domingo'
    description 'Futebol com o Christian'
    event_date 30.days.from_now
    pay_date 37.days.from_now
    total_price '200'
    participants_amount '10'
  end
end
