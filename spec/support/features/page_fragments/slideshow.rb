module PageFragments
  module Slideshow
    include PageFragments::Util

    def content
      browser.find('[data-testid="slide-content"]').text
    end

    def choose(next_slide_link_text)
      browser
        .find('[data-testid="next-slide"]')
        .click_on(next_slide_link_text)
    end
  end
end
