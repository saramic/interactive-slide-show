module PageFragments
  module Util
    def form_action(action, args = {})
      args.each do |field, value|
        browser.fill_in(field.to_s, with: value)
      end
      browser.click_on(action)
    end

    def select(args = {})
      args.each do |field, value|
        browser.select(value, from: field.to_s)
      end
    end

    def key_value(key_finder, value_finder)
      browser.synchronize do
        keys = browser.find_all(key_finder).map(&:text)
        values = browser.find_all(value_finder).map(&:text)
        key_values = values
                     .each_slice(keys.length)
                     .map { |value| keys.zip(value).to_h.with_indifferent_access }
        key_values.length == 1 ?
          key_values.first :
          key_values
      end
    end
  end
end
