module PageFragments
  module Dashboard
    include PageFragments::Util

    class Navigation
      def initialize(node)
        @node = node
      end

      def account
        @node.find('[data-testid="account"]').text
      end
    end

    def title
      browser.find("h1").text
    end

    def navigation
      Navigation.new(browser.find(".navigation"))
    end

    def messages
      browser.find(".flashes").text
    end

    def details
      key_value("dl dt", "dl dd")
    end

    def add_slide(args = {})
      form_action("Slides")
      form_action("New slide")
      args
        .select { |label, value| label.to_sym == :Slideshow }
        .each { |label, value|
        select(label => value)
      }
      form_action(
        "Create Slide",
        args.select { |label, value| label.to_sym != :Slideshow }
      )
    end
  end
end