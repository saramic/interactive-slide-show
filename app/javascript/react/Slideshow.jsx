import React from "react";
import { Link } from "@reach/router";
import { Query } from "react-apollo";
import { gql } from "apollo-boost";
import { string } from "prop-types";
import Slide from "./Slide";
import NextSlide from "./NextSlide";

const GET_SLIDESHOW = gql`
  query Slideshow($id: ID!) {
    slideshow(id: $id) {
      id
      title
      slides {
        id
        title
        content
      }
    }
  }
`;

export default function Slideshow({ slideshowId, slideId }) {
  return (
    <Query query={GET_SLIDESHOW} variables={{ id: slideshowId }}>
      {({ loading, error, data }) => {
        if (loading) return "Loading ...";
        if (error) return `Error! ${error.message}`;

        return (
          <>
            <Link to="/"> home</Link>
            <Link
              to={`/slideshows/${slideshowId}/slides/${data.slideshow.slides[0].id}`}
            >
              start
            </Link>
            <Slide
              slide={
                data.slideshow.slides.filter(slide => slide.id === slideId)[0]
              }
            />
            <section data-testid="next-slide">
              {data.slideshow.slides.map(slide => (
                <NextSlide
                  key={slide.id}
                  slideshowId={slideshowId}
                  slide={slide}
                />
              ))}
            </section>
          </>
        );
      }}
    </Query>
  );
}

Slideshow.propTypes = {
  slideshowId: string,
  slideId: string
};

Slideshow.defaultProps = {
  slideshowId: undefined,
  slideId: undefined
};
