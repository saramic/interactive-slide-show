import React from "react";
import ReactDOM from "react-dom";
import ViewingApp from "../react/ViewingApp";

document.addEventListener("DOMContentLoaded", () => {
  ReactDOM.render(
    <ViewingApp />,
    document.body.appendChild(document.createElement("div"))
  );
});
