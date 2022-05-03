class PaymentLogs::PaymentDistributor

  attr_reader   :payment_log, :main_invoice, :client, :seller

  def initialize(payment_log:, invoice_id:, seller_id: )
    @payment_log  = payment_log
    @client       = payment_log.client
    @main_invoice = Invoice.find(invoice_id)
    @seller       = AdminUser.find(seller_id)
  end

  def call
    allocate_payment(main_invoice)
    distribute_remaining_amount
  end

  private

  def allocate_payment(invoice)
    return if payment_log.depleted? || invoice.paid_out?

    payment_log.payments.create(
      amount:  calculate_amount(invoice),
      invoice: invoice,
      seller:  seller
    )
  end

  def calculate_amount(invoice)
    return true if invoice.paid_out?

    if invoice.remaining_debt <= payment_log.remaining_balance
      invoice.remaining_debt
    else
      payment_log.remaining_balance
    end
  end

  def distribute_remaining_amount
    client.pending_invoices.each do |invoice|
      break if payment_log.depleted? || client.pending_invoices.empty?
      allocate_payment(invoice)
    end
  end

end
