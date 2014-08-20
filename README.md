# JoshKCupid: an OkCupid Clone

[JoshKCupid](http://joshkcupid.herokuapp.com/) is a clone of [OkCupid](http://www.okcupid.com), the popular dating app.  It was built by [Joshua Meisel](http://www.joshuameisel.me/) in Summer 2014.  You can view it [here](http://joshkcupid.herokuapp.com/).

## Features

JoshKCupid implements certain core features from the original site, most notably matching by question answering. Users can:

* Create a profile
* Upload photos
* Specify age and gender preferences in matches
* Answer questions and set preferred answers to help find compatible matches
* View other users' answers/answer preferences matched against their own
* Search for other users based on gender, orientation, age, location, and match percentage
* Send and receive messages, with unread message count displayed

## Technologies

JoshKCupid was built using the following technologies:

* **Back-End**: JoshKCupid has a Rails 4 back-end with a RESTful API. Custom SQL is used heavily in searching for users and viewing messages to optimize efficiency
* **Front-End**: JoshKCupid has a Backbone.js front-end to provide a smoother user experience and minimize requests to the server.
* **Styling**: JoshKCupid was styled with custom CSS without the use of any third-party themes or tools.

## Todos

Additional features to implement include:

* Grab most recent message in conversation correctly in production, not just development
* Implement adding and deleting photos in Backbone
* Question-weighting
* User favoriting
* Track user's most recent login, and allow this as a search option
* Cron job that groups users based on pivotal questions (like political affiliation) to speed up ordering by match percentage