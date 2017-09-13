require 'rails_helper'

describe Transaction do
  before(:each) {
		@account1 = Account.create(balance: 100)
		@account2 = Account.create(balance: 50)
  }


	it "should be valid" do
		transaction = Transaction.new(source_account_id: @account1.id, destination_account_id: @account2.id, amount: 50)
		expect(transaction).to be_valid
	end

	it "should be invalid without a source_account_id" do
		transaction = Transaction.new(source_account_id: nil, destination_account_id: @account2.id, amount: 50)
		transaction.valid?
		expect(transaction.errors[:source_account_id]).to include("can't be blank")
	end

	it "should be invalid without a destination_account_id" do
		transaction = Transaction.new(source_account_id: @account1.id, destination_account_id: nil, amount: 50)
		transaction.valid?
		expect(transaction.errors[:destination_account_id]).to include("can't be blank")
	end

	it "should be invalid without a amount" do
		transaction = Transaction.new(source_account_id: @account1.id, destination_account_id: @account2.id, amount: nil)
		transaction.valid?
		expect(transaction.errors[:amount]).to include("can't be blank")
	end

	it "should be invalid if source account not exist" do
		transaction = Transaction.new(source_account_id: 3, destination_account_id: @account2.id, amount: 10)
		transaction.valid?
		expect(transaction.errors[:source_account_id]).to include("Account does not exist")		
	end

	it "should be invalid if destination account not exist" do
		transaction = Transaction.new(source_account_id: @account1.id, destination_account_id: 3, amount: 10)
		transaction.valid?
		expect(transaction.errors[:destination_account_id]).to include("Account does not exist")		
	end

	it "should be invalid if amount less than 0" do
		transaction = Transaction.new(source_account_id: @account1.id, destination_account_id: @account2.id, amount: 0)
		transaction.valid?
		expect(transaction.errors[:amount]).to include("must be greater than 0")		
	end

	it "should be invalid if source account not have funds" do
		transaction = Transaction.new(source_account_id: @account1.id, destination_account_id: @account2.id, amount: 101)
		transaction.valid?
		expect(transaction.errors[:amount]).to include("must be less than or equal to 100.0")		
	end

	it "should be invalid if destination account same as source account" do
		transaction = Transaction.new(source_account_id: @account1.id, destination_account_id: @account1.id, amount: 10)
		transaction.valid?
		expect(transaction.errors[:destination_account_id]).to include("Can't be the same as source account")		
	end
	
end
