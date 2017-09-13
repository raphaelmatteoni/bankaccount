class Transaction < ActiveRecord::Base
  #Validations
  validates :source_account_id, presence: true
  validates :destination_account_id, presence: true
  validates :amount, presence: true
  validate  :check_if_accounts_exists
  validate  :check_if_destination_account_same_as_source_account
  validates_numericality_of :amount, greater_than: 0
  validates_numericality_of :amount, less_than_or_equal_to: :source_account_balance, if: lambda { |o| o.errors.empty? }


  #Hooks
  after_save :transfer_money

  def source_account_balance
    Account.find_by_id(self.source_account_id).balance
  end

  def check_if_destination_account_same_as_source_account
    errors.add(:destination_account_id, "Can't be the same as source account") if source_account_id == destination_account_id
  end

  def check_if_accounts_exists
    errors.add(:source_account_id, 'Account does not exist') if !Account.exists?(self.source_account_id)
    errors.add(:destination_account_id, 'Account does not exist') if !Account.exists?(self.destination_account_id)
  end

  def transfer_money
    source_account = Account.find(self.source_account_id)
    destination_account = Account.find(self.destination_account_id)
    source_account.debit(self.amount)
    destination_account.credit(self.amount)
  end

end
