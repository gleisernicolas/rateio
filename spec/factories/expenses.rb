FactoryBot.define do
  factory :expense do
    title 'Futebol de domingo'
    description 'Futebol com o Christian'
    event_date '17/12/2017'
    pay_date '10/12/2017'
    total_price '200'
    participants_amount '22'
  end
end
