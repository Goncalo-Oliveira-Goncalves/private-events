class User < ApplicationRecord
    has_many :hosted_events, 
        class_name: "User"
    has_many :attended_events, 
        class_name: "User", 
        join_table: "event_users", 
        foreign_key: "event_id"
    has_secure_password
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
    validates_uniqueness_of :email
end