# Steps to obtaining tweet data via Twitter API

# Preparatory actions
# NOTE: If you don't have the 'twitteR' package run install.packages("twitteR")
# Usually any dependency will be installed along with it. If you get an error
# saying that a package is missing, use the install.packages("<package name>")
# to download such a package as well.

# After attaching the package(s) the next 4 lines represent the app's OAuth
# credentials. Please keep this secret! The GitHub version of this file will
# not have these details.

library(twitteR)

# 1. Register the session with Twitter (may elicit a response from the user)
setup_twitter_oauth(consumer_key = consumer_key,
                    consumer_secret = consumer_secret,
                    access_token = access_token,
                    access_secret = access_secret)
              

# 2. Search Twitter for a term e.g. nesreanigeria (NESREA handle)
tweets <- searchTwitter(searchString = "nesreanigeria",
                        n = 100,
                        since = "2017-09-25")

# 3. Convert the data into a data frame
dftweets <- twListToDF(tweets)
View(dftweets)

# 4. Analyse
# Draw a graph
# TO BE CONTINUED