class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :send_welcome_email 

  private 
    def send_welcome_email
      SendEmailsJob.set(wait: 15.seconds).perform_later(self)
    end
end
