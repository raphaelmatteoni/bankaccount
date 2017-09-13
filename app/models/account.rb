class Account < ActiveRecord::Base
	#alidations
  validates :balance, presence: true

  #instance_methods
	def credit(amount)
		self.balance += amount
		self.save!
	end

	def debit(amount)
		self.balance -= amount
		self.save!
	end
end
