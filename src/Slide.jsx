import React, { useState } from "react";

const Slide = () => {
  const [counts, setCounts] = useState([0, 0]);
  return (
    <>
      slide
      <div>
        result
        <div>{counts[0]}</div>
        <div>{counts[1]}</div>
      </div>
      <div>status</div>
      <div>
        options
        <div onClick={() => setCounts([counts[0] + 1, counts[1]])}>
          choice 1
        </div>
        <div onClick={() => setCounts([counts[0], counts[1] + 1])}>
          choice 2
        </div>
      </div>
    </>
  );
};

export default Slide;
