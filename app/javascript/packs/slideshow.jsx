import React from "react";
import ReactDOM from "react-dom";
import SlideshowApp from "../react/SlideshowApp";

document.addEventListener("DOMContentLoaded", () => {
  ReactDOM.render(
    <SlideshowApp />,
    document.body.appendChild(document.createElement("div"))
  );
});
