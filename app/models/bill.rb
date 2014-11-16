class Bill < ActiveRecord::Base
    has_many :sponsors
    has_many :politicians, through: :sponsors
end
