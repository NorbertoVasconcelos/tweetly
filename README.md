# tweetly

My solution for a minimalistic version of Twitter.

## Challenge

You have to implement a minimalistic version of Twitter.
In this "twitter" the users can:
- Publish tweets of 280 characters. See a feed of tweets
- Like (and unlike) any tweet they see on the feed.
- Sort the feed by tweet creation date, number of likes and recommended (a sorting algorithm of your choice).

This is it. Don't worry about:
- Making a pretty UI. It just needs to be functional.
- Making the users registering and login in the app. Simply create a user for each mobile device id. You can give it a random username.

Use Flutter and Firebase.

### Challenge decisions

- My recommended sort orders the list of tweets by the amount of text they contain, cause I like'em short and sweet.
- Due to the time constraint and not a lot of focus required for the UI, the sorting buttons do not show which is currently selected (they do however work 👀).
- I opted to not use streams in this project, so the UI won't immediately reflect changes done on other devices (Tapping a sort button will refresh though).
- I didn't use Cloud FireStore Functions, as a billing method was required, but I imagine it would have made my life easier on the frontend development and would facilitate rule enforcement.
- I only tested on iOS.

## Getting Started

Run `flutter pub get` and 🙏

## Design Choices

I opted for using Bloc pattern for state management in this project.

I've organized the project by features —> `authentication` and `feed`.
Each feature is split into `data`, `models` and `presentation`.

### data

Contains the feature's datasource and repository. The datasource feeds the repository which in turn will feed the bloc.

### models

Contains the models for any objects used in this feature.

### presentation

Contains this feature's UI (pages) and the bloc, along with it's events and states.
