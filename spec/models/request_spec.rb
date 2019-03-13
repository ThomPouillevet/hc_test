require 'rails_helper'

RSpec.describe Request, type: :model do
  it "is valid with a name, email, phone, biography and state" do
    expect(FactoryGirl.build(:request)).to be_valid
  end

  it "is invalid without a name" do
    user = FactoryGirl.build(:request, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end

  it "is invalid without an email address" do
    user = FactoryGirl.build(:request, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is invalid without a valid email address" do
    user = FactoryGirl.build(:request, email: "mymail@")
    user.valid?
    expect(user.errors[:email]).to include("is invalid")
  end

  it "is invalid if email address contains spaces" do
    user = FactoryGirl.build(:request, email: "email_with_space@gmail.com ")
    user.valid?
    expect(user.errors[:email]).to include("is invalid")
  end

  it "is invalid with a duplicate email address" do
    FactoryGirl.create(:request, email: "tom@example.com")
    request = FactoryGirl.build(:request, email: "tom@example.com")
    request.valid?
    expect(request.errors[:email]).to include("has already been taken")
  end

  it "is invalid without an phone number" do
    user = FactoryGirl.build(:request, phone: nil)
    user.valid?
    expect(user.errors[:phone]).to include("can't be blank")
  end

  it "is invalid without a valid phone number" do
    user = FactoryGirl.build(:request, phone: "049382")
    user.valid?
    expect(user.errors[:phone]).to include("is invalid")
  end

  it "is invalid if phone number contain spaces" do
    user = FactoryGirl.build(:request, phone: "0478967564 ")
    user.valid?
    expect(user.errors[:phone]).to include("is invalid")
  end

  it "is invalid with a duplicate phone number" do
    FactoryGirl.create(:request, phone: "0478764534")
    request = FactoryGirl.build(:request, phone: "0478764534")
    request.valid?
    expect(request.errors[:phone]).to include("has already been taken")
  end

  it 'is invalid with a long biography' do
    request = FactoryGirl.build(:request, biography: "Hello, my name is John Doe. I'm very very talkative and being synthetical is really not my thing. In fact, I created this request to have the fantastic opportunity to talk, talk and talk to a lot of people. Talking in a coworking space might seem akward but missing the chance to meet fantastic people is a shame... Feel free to tell me to shut it up if you don't want to be disturb and work. But you'd miss a chance to talk to me haha. Appart from being talkative I'm a conference speaker and a story teller. Did I tell you my name? It's John!")
    request.valid?
    expect(request.errors[:biography]).to include('is too long (maximum is 500 characters)')
  end

  it 'is invalid with a non permitted state' do
    request = FactoryGirl.build(:request, state: 'unknown')
    request.valid?
    expect(request.errors[:state]).to include('unknown is not a valid state')
  end

  it "changes request's state to 'accepted'" do
    request = FactoryGirl.build(:request, state: 'confirmed')
    request.accept!
    expect(request.state).to eq('accepted')
  end

end
