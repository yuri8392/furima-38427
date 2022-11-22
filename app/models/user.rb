class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :purchases

  with_options presence: true do
    validates :nickname
    validates :birthday
  end

  validates :password,
            format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: 'は半角英数字を入力してください' }

  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'は全角で入力してください' } do
    validates :last_name
    validates :first_name
  end

  with_options presence: true,
               format: { with: /\A[\p{katakana}ー－&&[^ -~｡-ﾟ]]+\z/,
                         message: 'は全角カタカナで入力してください' } do
    validates :last_name_kana
    validates :first_name_kana
  end
end
