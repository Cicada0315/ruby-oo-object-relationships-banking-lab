class Transfer
  attr_accessor :bank_account, :sender, :receiver, :amount, :status
  def initialize(sender, receiver, amount)
    @sender=sender
    @receiver=receiver
    @amount=amount
    @status="pending"
  end

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    if self.valid? && sender.balance > @amount && @status=="pending"
      sender.withdrawal(amount) && receiver.deposit(amount)
      self.status="complete"
    else
      self.status="rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if status== "complete"
      sender.deposit(amount) && receiver.withdrawal(amount)
      self.status="reversed"
    end
  end
end