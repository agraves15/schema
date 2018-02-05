class SchemesUser < ApplicationRecord
  belongs_to :scheme
  belongs_to :user
end
