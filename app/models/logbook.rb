class Logbook < ApplicationRecord
  belongs_to :user
  has_many :entries
  has_and_belongs_to_many :columns, -> { distinct }
  
  before_validation :set_defaults
  
  validates :name, presence: true, uniqueness: {scope: :user_id}
  validates :private, inclusion: { in: [ true, false ] }
  
  private
  
    def set_defaults
      self.private = false if self.private.nil?      
    end
end
