module RazorpayApplication
  class RazorpayGateway
    RAZORPAY_KEY_ID = "rzp_test_skUYRxPAvmNgCW"
    RAZORPAY_KEY_SECRET = "wlmFosZGV6kZ3OpuUPXiIaqw"
    def initialize
      Razorpay.setup(RAZORPAY_KEY_ID, RAZORPAY_KEY_SECRET)
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
        "callback_url": "0.0.0.0:3000",
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

  end
end
