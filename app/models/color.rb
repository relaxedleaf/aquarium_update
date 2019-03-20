class Color < ApplicationRecord
    before_destroy :ensure_not_referenced_by_any_livestock
    has_many :livestocks
    belongs_to :user
    
    validates_uniqueness_of :name, :scope => :user_id
    validates :name, presence: true
    
    private
    #ensure that there are no line items referencing this product
    def ensure_not_referenced_by_any_livestock
        unless livestocks.empty?
            errors.add(:base, 'There are livestocks associated with this color')
            throw :abort
        end
    end
end
