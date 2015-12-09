# GitHub Status Hue

Changes a Phillips Hue light's color and flashes based on GitHub's status

## What it does

* When GitHub's status changes to `minor` the light will turn to yellow and flash for 15 seconds.
* When GitHub's status changes to `major` the light will turn to red and flash for 15 seconds.
* When GitHub's status changes to `good` the light will turn white and stop blinking.

## How it works

When GitHub's status changes, @githubstatus Tweets. We use that as an inbound web hook to tell the app to change the light's state. The app streams the account's Tweets, and uses GitHub's status API to grab the current site status any time in changes, and then makes a call to an undocumented Hue API to set the light accordingly.

## Constraints

I wanted the app to do two things:

1. Change immediately. (e.g. no polling the RSS feed)
2. Work outside the light's home network (e.g., over the internet).

## Prior art and special thanks

* @johndbritton's [Twitterhook](https://github.com/johndbritton/twitterhook) for streaming Tweets
* @websages's [GitHub Status Hue](https://github.com/websages/github-status-hue) for the idea and undocumented API

## Configuration

You'll want to set the following configuration variables:

* `TWITTER_CONSUMER_KEY`
* `TWITTER_CONSUMER_SECRET`
* `TWITTER_OAUTH_TOKEN`
* `TWITTER_OAUTH_TOKEN_SECRET`
* `TWITTER_ID` - An optional, alternate Twitter user ID to trigger the event, for debugging
* `HUE_BRIDGE_ID`
* `HUE_ACCESS_TOKEN`
* `HUE_LIGHT_ID` - numeric ID of light on bridge, e.g. 1, 2, or 3

Folow [these instructions](http://blog.paulshi.me/technical/2013/11/27/Philips-Hue-Remote-API-Explained.html) to get your bridge ID and token.
