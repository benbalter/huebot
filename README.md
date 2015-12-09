# GitHub Status Hue

Sets a Phillips Hue light based on GitHub's status

## Prior art

* @johndbritton's [Twitterhook](https://github.com/johndbritton/twitterhook) for streaming Tweets
* @websages's [GitHub Status Hue](https://github.com/websages/github-status-hue) for the idea

## Constraints

I wanted the app to do two things:

1. Change immediately. (e.g. no polling)
2. Work outside the light's home network (e.g., over the internet).

## Configuration

You'll want to set the following configuration variables:

* `TWITTER_CONSUMER_KEY`
* `TWITTER_CONSUMER_SECRET`
* `TWITTER_OAUTH_TOKEN`
* `TWITTER_OAUTH_TOKEN_SECRET`
* `IFTTT_MAKER_KEY`
* `TWITTER_ID` - An optional, alternate Twitter user ID to trigger the event, for debugging
