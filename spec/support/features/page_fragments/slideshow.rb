module PageFragments
  module Slideshow
    include PageFragments::Util

    def content
      browser.find("main").text
    end
  end
end
