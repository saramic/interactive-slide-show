import React, { useState } from "react";

const Display = ({ counts }) => (
  <div className='flex items-stretch-'>
    <div
      className={`flex-1 ${counts[0] < counts[1] &&
        "text-gray-500"} text-center px-4 py-2 m-2`}
    >
      {counts[0]}
    </div>
    <div
      className={`flex-1 ${counts[0] > counts[1] &&
        "text-gray-500"} text-center px-4 py-2 m-2`}
    >
      {counts[1]}
    </div>
  </div>
);

const Progress = ({ timeLeft }) => (
  <div className='flex items-stretch'>
    <div className='flex-1 bg-gray-300'>
      <div
        className='bg-gray-700'
        style={{ width: `${100 - timeLeft}%`, height: "3px" }}
      />
    </div>
    <div className='flex-1 bg-gray-700'>
      <div
        className='bg-gray-300'
        style={{ width: `${timeLeft}%`, height: "3px" }}
      />
    </div>
  </div>
);

const Choice = ({ updateCount, index }) => (
  <div
    className='flex-1 text-center px-4 py-2 m-2'
    onClick={() => updateCount(index)}
  >
    choice {index}
  </div>
);

const Choices = props => (
  <div className='flex items-stretch h-16'>
    {[0, 1].map(index => (
      <Choice key={index} {...props} index={index} />
    ))}
  </div>
);

const Slide = () => {
  const [counts, setCounts] = useState([0, 0]);
  const [timeLeft, setTimeLeft] = useState(100);

  const updateCount = counterIndex => {
    const updatedCounts = counts;
    updatedCounts[counterIndex] = updatedCounts[counterIndex] + 1;
    setCounts(updatedCounts);
    setTimeLeft(timeLeft - 1);
  };

  return (
    <div className='text-gray-100'>
      <Display counts={counts} />
      <div className='w-full pin-b absolute bottom-0 left-0'>
        <Progress timeLeft={timeLeft} />
        <Choices updateCount={updateCount} />
      </div>
    </div>
  );
};

export default Slide;
