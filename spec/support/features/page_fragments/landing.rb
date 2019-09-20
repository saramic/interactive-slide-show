module PageFragments
  module Landing
    def follow_action(action)
      browser.click_on(action)
    end

    def messages
      browser.find("#flash").text
    end
  end
end
