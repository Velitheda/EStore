class Order < ActiveRecord::Base
  PAYMENT_TYPES = [ "Cheque", "Credit card", "Purchase order" ]
end
