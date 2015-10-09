class UserCreator
  attr_reader :user_params

  def initialize(user_params)
    @user_params = user_params
  end

  def call
    user_params[:username] = username
    user_params[:password] = 'Secret99'
    User.create(user_params)
  end

  private

  def username
    I18n.transliterate("#{user_params[:name][0..2]}#{user_params[:surname][0..2]}#{rand(1..99)}").downcase
  end
end