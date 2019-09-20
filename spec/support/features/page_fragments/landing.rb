module PageFragments
  module Landing
    def follow_action(action)
      browser.click_on(action)
    end

    def messages
      browser.find("#flash").text
    end

    def sign_up(credentials)
      credentials.each do |field, value|
        browser.fill_in(field.to_s, with: value)
      end
      follow_action("Sign up")
    end
  end
end
