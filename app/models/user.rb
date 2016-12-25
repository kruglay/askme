require 'openssl'

class User < ActiveRecord::Base
  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new
  VALID_BG_COLORS =
  [
      [I18n.t('models.user.color.default'),'#005a55', {style: 'color: #005a55'}, {class: "form-select-option"}],
      [I18n.t('models.user.color.slatergray'),'slategray', {style: 'color: slategray'}, {class: "form-select-option"}],
      [I18n.t('models.user.color.blue'),'blue', {style: 'color: blue'}, {class: "form-select-option"}],
      [I18n.t('models.user.color.turquoise'),'turquoise', {style: 'color: turquoise'}, {class: "form-select-option"}],
      [I18n.t('models.user.color.orange'),'orange', {style: 'color: orange'}, {class: "form-select-option"}],
      [I18n.t('models.user.color.green'),'green', {style: 'color: green'}, {class: "form-select-option"}]
  ]

  has_many :questions

  validates :email, :username, presence:true
  validates :email, :username, uniqueness:true

  attr_accessor :password
  #make validates
  validates_presence_of :password, on: :create
  validates_confirmation_of :password

  validates_format_of :email, with: /\A[\w]+@[\w]+\.[\w]+\z/

  validates_length_of :username, maximum: 40
  validates_format_of :username, with: /\A[\w]+\z/

  validates_inclusion_of :color, in: VALID_BG_COLORS.map {|el| el[1]},
                         on: :update

  before_save :encrypt_password
  before_validation { self.username.downcase! }

  def encrypt_password
    if self.password.present?

      # создаем т. н. "соль" - рандомная строка усложняющая задачу хакерам
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      # создаем хэш пароля — длинная уникальная строка, из которой невозможно восстановить
      # исходный пароль
      self.password_hash = User.hash_to_string(
          OpenSSL::PKCS5.pbkdf2_hmac(self.password, self.password_salt, ITERATIONS, DIGEST.length, DIGEST)
      )
    end
  end

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  # Основной метод для аутентификации юзера (логина)
  # Проверяет email и пароль, если пользователь с такой комбинацией есть в базе
  # возвращает этого пользователя.
  # Если нету — возвращает nil
  def self.authenticate(email, password)
    user = find_by(email: email) # сперва находим кандидата по email

    # ОБРАТИТЕ внимание: сравнивается password_hash, а оригинальный пароль так никогда
    # и не сохраняется нигде!
    if user.present? && user.password_hash == User.hash_to_string(OpenSSL::PKCS5.pbkdf2_hmac(password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST))
      user
    else
      nil
    end
  end
end
