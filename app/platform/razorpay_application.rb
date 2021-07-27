module RazorpayApplication
  class RazorpayGateway
    include OrdersApplication

    RAZORPAY_KEY_ID = "rzp_test_skUYRxPAvmNgCW"
    RAZORPAY_KEY_SECRET = "wlmFosZGV6kZ3OpuUPXiIaqw"
    def initialize
      Razorpay.setup(RAZORPAY_KEY_ID, RAZORPAY_KEY_SECRET)
    end

    def self.get_razorpay_id
      RAZORPAY_KEY_ID
    end

    def self.get_razorpay_secret
      RAZORPAY_KEY_SECRET
    end

    def create_rp_order(total_price, order_id)
      total_price = (total_price.to_i * 100)
      Razorpay::Order.create amount: total_price, currency: 'INR', receipt: order_id
    end

    def create_options(rp_order, order)
      options = {
        "key": RAZORPAY_KEY_ID,
        "amount": order[:total_price],
        "currency": "INR",
        "name": "Online Grocer",
        "description": "Test Transaction",
        :order_id => rp_order["id"],
        "callback_url": "/order/order_confirmation",
        "prefill": {
            "name": order[:fname],
            "email": "gaurav.kumar@example.com",
            "contact": "9999999999"
        },
        "notes": {
            "address": "Razorpay Corporate Office"
        },
        "theme": {
            "color": "#239B56"
        }
      }
      return options
    end

    def rp_signature_verified?(order, rp_params)
      result = false
      rp_order_id = order[:rp_order_id]
      digest = OpenSSL::Digest.new('sha256')
      hash  = OpenSSL::HMAC.hexdigest(digest,
                                      RazorpayGateway.get_razorpay_secret(),
                                      rp_order_id+"|"+rp_params['razorpay_payment_id'])

      if(hash == rp_params["razorpay_signature"])
        change_order_status(order, Order::RP_SIGNATURE_VERIFIED)
      else
        change_order_status(order, Order::RP_SIGNATURE_VERIFIED)
      end

      if (order[:status] == Order::RP_SIGNATURE_VERIFIED.to_s)
        result = true
      end

      result
    end


  end
end
