module PageFragments
  module Landing
    include PageFragments::Util

    def messages
      browser.find("#flash").text
    end
  end
end
