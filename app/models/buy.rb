class Buy < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  scope :bought, lambda { |book_id| {conditions: "book_id = #{book_id}"} }

  def bought?
    1 == self.buy_status
  end
end
