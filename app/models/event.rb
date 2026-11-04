class Event < ApplicationRecord
    belongs_to :host, class_name: "User"
    has_many :guests,
        class_name: "User", 
        join_table: "event_users", 
        association_foreign_key: "user_id"
end