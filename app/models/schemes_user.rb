class SchemesUser < ActiveRecord::Base
  belongs_to :scheme
  belongs_to :user
end
