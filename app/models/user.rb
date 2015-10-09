class User < ActiveRecord::Base
  attr_accessor :login

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, :name, :surname, :expiration_date, presence: true
  validates :username, format: { with: /\A[a-z0-9]+\z/ }
  validates :username, uniqueness: true
  validates :username, length: { maximum: 8, too_long: "%{count} characters is the maximum allowed"  }
  validate :expiration_date_cannot_be_in_the_past

  before_save :titleize_names

  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions.to_h).first
    end
  end

  private

  def titleize_names
    self.name = name.titleize
    self.surname = surname.titleize
  end

  def expiration_date_cannot_be_in_the_past
    if expiration_date.present? && expiration_date < Date.today
      errors.add(:expiration_date, "can't be in the past")
    end
  end
end
