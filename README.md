# Interactive Slide Show

## Aim

Create an interactive slide show presentation "app" that allows a talk
presenter to have real time interaction from the audience.

## Goal

- have a "choose your own adventure" style slide show to present at [Ruby
  Melbourne Meetup - Oct
  2019](https://www.meetup.com/Ruby-On-Rails-Oceania-Melbourne/events/hrznsqyznbnc/)

  - [Issue #140](https://github.com/rails-oceania/melbourne-ruby/issues/140)

- have a "worm" for a joint slide show by my kids. The worm will be a death
  match as to who get's a ticket to join me at [Rails Camp AU #26 Nov
  2019](https://rails.camp/#au_nov_2019).
  - @squiggla [Issue #134](https://github.com/rails-oceania/melbourne-ruby/issues/134)
  - @tamadillo [Issue #139](https://github.com/rails-oceania/melbourne-ruby/issues/139)

## Background

A learning exercise in using Apollo and GraphQL with subscriptions over web
sockets.

Yes I know there are plenty of these tools, even lists of 10 best of tools, but
for the moment I am playing "not invented here".

## Build

currently spiking using create-react-app

```sh
cd server
yarn
yarn start
yarn test
```

```sh
cd client
yarn
yarn start
yarn test
```

## TODO

some initial spikes

- [ ] build MVP
- [ ] Proof of concpet of using apollo ~~and subscriptions over web socket~~

  - [x] **in progress** follow getting started -
        https://www.apollographql.com/docs/tutorial/introduction/

    - [x] get basic voting data source up
    - [x] connect client to voting data source
    - [ ] demo Apollo GraphQL subscriptions

      - putting this on hold as it may not be the best option and polling is not a show stopper so pushing forward in getting a working product first

        - is polling better in this case [When to use subscriptions](https://www.apollographql.com/docs/react/advanced/subscriptions/#when-to-use-subscriptions)
        - [subscription client setup](https://www.apollographql.com/docs/react/advanced/subscriptions/#client-setup)
        - [subscription server setup](https://www.apollographql.com/docs/graphql-subscriptions/)

- [ ] **in progress** visual design asspect of the choice module both for
      participant ~~and presenter~~
  - [x] setup a CSS framework like Tailwind CSS
    - https://itnext.io/how-to-use-tailwind-css-with-react-16e9d478b8b1
    - https://medium.com/@mikeeeeeeey/create-react-app-tailwind-css-feat-postcss-631d9e33ba8c
  - [ ] animate the progress bar - probably React start and stop? and CSS for
        smothness
- [ ] plugin ability to control [MDX deck](https://github.com/jxnblk/mdx-deck)
      a proposed first slide show support tool
- [ ] plugin for MDX deck
- [ ] plugin to other slide shows like Google Sheets
- [ ] interactive controller as a service
- [ ] slide show as a service with the controller
- [ ] profit \$\$\$

# RAILS README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
