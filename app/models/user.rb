class User < ApplicationRecord
    has_many :hosted_events, 
        class_name: "User"
    has_many :attended_events, 
        class_name: "User", 
        join_table: "event_users", 
        association_foreign_key: "event_id"
end