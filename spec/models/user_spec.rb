describe User do
  it { should ensure_length_of(:password).is_at_least(6) }
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:gender) }
  it { should validate_presence_of(:orientation) }
  it { should validate_presence_of(:dob) }
  it { should validate_presence_of(:country) }
  it { should validate_presence_of(:email) }
end