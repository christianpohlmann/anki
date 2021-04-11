# Bash scripts to populate Anki decks with sound samples from forvo

## Prerequisites
 * Anki must be setup with note types fitting the resulting CSV
 * forvo API key
 * set up environment variable ANKI_MEDIA to point to your Anki's collection.media directory
 
## Howto
 * ./duplicate_first_column.sh <input.csv> <output1.csv>
   All this script is is duplicate each word of the source language. The idea behind this is that you may want to use a different word for the sound sample than is displayed. A valid input.csv can be viewed in sample.csv
 * ./query_forvo.sh <output1.csv> <output.csv>
   This queries forvo and downloads audio samples and puts them in your $ANKI_MEDIA folder. The resulting output.csv can then be imported into Anki.
