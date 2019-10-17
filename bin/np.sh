#!/usr/bin/env bash
# now playing
# requires the last.fm API key

source ~/.lastfm    # `export API_KEY="<key>"`
fg="$(xres color15)"
light="$(xres color8)"

USER="icyphox"
URL="http://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks"
URL+="&user=$USER&api_key=$API_KEY&format=json&limit=1&nowplaying=true"
NOTPLAYING=" "
RES=$(curl -s $URL)
NOWPLAYING=$(jq '.recenttracks.track[0]."@attr".nowplaying' <<< "$RES" | tr -d '"')


if [[ "$NOWPLAYING" = "true" ]]
then
	TRACK=$(jq '.recenttracks.track[0].name' <<< "$RES" | tr -d '"')
	ARTIST=$(jq '.recenttracks.track[0].artist."#text"' <<< "$RES" | tr -d '"')
	echo -ne "%{F$light}$TRACK %{F$fg}by $ARTIST"
else
	echo -ne "$NOTPLAYING"
fi
