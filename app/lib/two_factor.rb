require 'httparty'
class TwoFactor
  include HTTParty
  TWO_FACTOR_API_KEY = "6aaf8d96-d0f9-11eb-8089-0200cd936042"

  def self.send_passcode(phone)
    # response = get("https://2factor.in/API/V1/#{TWO_FACTOR_API_KEY}/SMS/#{phone}/AUTOGEN/MUNNAH")
    # response.parsed_response
    binding.pry
    {"Status"=>"Success", "Details"=>"77382b51"}
  end

  def self.verify_passcode(session_key, code)
    # response = post("https://2factor.in/API/V1/#{TWO_FACTOR_API_KEY}/SMS/VERIFY/#{session_key}/#{code}")
    # response.parsed_response
    {"Status"=>"Success", "Details"=>"OTP Matched"}
  end

end
