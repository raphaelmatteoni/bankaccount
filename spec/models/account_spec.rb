require 'rails_helper'

describe Account do 
	it "should be valid" do
		account = Account.new(balance: 0)
		expect(account).to be_valid
	end
	
	it "should be invalid without a balance" do
		account = Account.new(balance: nil)
		account.valid?
		expect(account.errors[:balance]).to include("can't be blank")
	end
end