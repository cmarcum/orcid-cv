# orcid-cv
Create a nicely formatted CV from an ORCID record

# summary
This package can be used to create a nicely formatted, printable, curriculum vitae from an [ORCID](https://www.orcid.org) id. The XML scraping and parsing is done via javacript ([fetch-orcid.js](fetch-orcid.js)) from a static orcid record: `https://pub.orcid.org/v3.0/${ORCID_ID}/record` (where `${ORCID_ID}` is 12-digit orcid id). Rendering of the XML is done via xsl (XML stylesheets): [orcid-to-cv.js](orcid-to-cv.js). Formatting is provided via fully customizable CSS: [cv-style](cv-style)

A live demonstration is available here: [https://cmarcum.github.io/orcid-cv](https://cmarcum.github.io/orcid-cv)

This is a work-in-progress, built as a proof-of-concept. Please feel free to contribute via issues or pull-requests. 

# installation
 - fork, clone, or download the repository.
 - tune paramaters in [fetch-orcid.js](fetch-orcid.js) (see below)
 - deploy via your github pages or webserver

# setup
There are two, self-explanatory tuneable parameters in [fetch-orcid.js](fetch-orcid.js):
```
const ORCID_ID = '0000-0002-0899-6143'; // Your ORCID ID goes here
const SHOW_JOURNAL_TITLES = true; // set this to true to show journal titles and false to help change the world
```
