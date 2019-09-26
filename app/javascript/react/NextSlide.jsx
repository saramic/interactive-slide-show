import React from "react";
import { Link } from "@reach/router";

function NextSlide(props) {
  const {
    slide: { id, title },
    slideshowId
  } = props;

  return <Link to={`/slideshows/${slideshowId}/slides/${id}`}>{title}</Link>;
}

export default NextSlide;
