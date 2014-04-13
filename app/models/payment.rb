class Payment < ActiveRecord::Base
  belongs_to :provider
end
