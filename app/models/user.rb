class User < ApplicationRecord
  has_one :wallet
  after_create :create_wallet
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  private

  def create_wallet
    Wallet.create(user_id: id)
  end
end
