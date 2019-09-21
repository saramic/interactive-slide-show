import React from "react";
import { shallow } from "enzyme";
import SlideshowApp from "./SlideshowApp";

describe("slideshow app", () => {
  it("renders", () => {
    const wrapper = shallow(<SlideshowApp />);
    expect(wrapper.find("div").text()).toEqual("slideshow app");
    expect(wrapper).toMatchInlineSnapshot(`
    <div>
      slideshow app
    </div>
  `);
  });
});
