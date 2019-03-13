FactoryGirl.define do
  factory :request do
    name "John Doe"
    email "john_doe@gmail.com"
    phone "0787654752"
    biography "I'm a fullstack RoR developer working remotely."
    state "accepted"
  end
end
