class Setting < ActiveRecord::Base
  validates :key, :value, presence: true
  validates :key, uniqueness: true
end
