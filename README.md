# AWB status checker

Lazy way to get notified when PTTR gets a hold of a package

Abusing the web free stack:

- heroku to host the checker
- uptimerobot.com to check for a url and send an email when the status changes

Config:

	heroku config:set AWB=RF.....I