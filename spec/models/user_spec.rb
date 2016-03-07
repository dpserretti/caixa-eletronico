describe User do

  before(:each) { @user = User.new(email: 'user@example.com') }

  subject { @user }

  it { should respond_to(:email) }

  it "#email returns a string" do
    expect(@user.email).to match 'user@example.com'
  end

end

RSpec.describe User, type: :model do
  context "Usuários" do
    it "Usuário válido?" do
      user = User.new
      user.name = "teste"
      user.email = "teste@teste.com"

      expect(user.valid?).to be_truthy
    end
    it "Usuário inválido sem nome?" do
      user = User.new
      user.name = nil
      user.email = "teste@teste.com"

      expect(user.valid?).to be_falsey
    end
    it "Usuário inválido sem email?" do
      user = User.new
      user.name = "teste"
      user.email = nil

      expect(user.valid?).to be_falsey
    end
  end
end

