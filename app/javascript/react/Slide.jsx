import React from "react";

function Slide(props) {
  const {
    slide: { content }
  } = props;

  return (
    <div data-testid="slide-content">
      <h1>{content}</h1>
    </div>
  );
}

export default Slide;
