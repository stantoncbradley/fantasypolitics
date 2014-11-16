class Bill < ActiveRecord::Base
    has_many :politicians, through: :PoliticianBills
    has_one :sponsor, :class_name => 'Politician'

end
