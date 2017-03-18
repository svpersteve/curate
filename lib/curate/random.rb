module Curate::Random
  DEFAULT_BITS = 160

  def base36(bits = DEFAULT_BITS)
    max_value  = 2**bits
    max_length = (bits * Math.log(2) / Math.log(36)).ceil
    value      = SecureRandom.random_number(max_value)

    value.to_s(36).rjust(max_length, '0')
  end

  def adblocker_safe_uuid
    uuid = SecureRandom.uuid

    if uuid =~ /^ad/
      adblocker_safe_uuid
    else
      uuid
    end
  end

  module_function :base36, :adblocker_safe_uuid
end
