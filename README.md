# orcid-cv
Create a nicely formatted CV from an ORCID record

# summary
This package can be used to create a nicely formatted, printable, curriculum vitae from an [ORCID](https://www.orcid.org) id. The XML scraping and parsing is done via javacript ([fetch-orcid.js](fetch-orcid.js)) from a static orcid record: `https://pub.orcid.org/v3.0/${ORCID_ID}/record` (where `${ORCID_ID}` is 12-digit orcid id). Rendering of the XML is done via xsl (XML stylesheets): [orcid-to-cv.xsl](orcid-to-cv.xsl). Formatting is provided via fully customizable CSS: [cv-style.css](cv-style.css).

Works records (i.e., publications) are processed using a simple algorithm to reduce the likelihood of duplicate titles appearing (i.e., as may result from unlinked versions where DOIs of preprints are independent from publisher DOIs for the same manuscript). 
 - record titles elements are roughly sanitized to ensure comparability
 - unique ids are assigned to each record title element
 - all-to-all comparison is made
 - duplicates are removed by sorting the stack by works record date, preserving the earliest works record associated with that title element in the stack (to maximize the likelihood that it is a preprint and not a journal version)
 - if a DOI element exists for a given works record, then it is linked to the title; if a URL exists but not a DOI, then the URL is linked;
Coding for the deduplication step was assisted by AI since initial attempts kept crashing-out and returning no data.

A live demonstration is available here: [https://cmarcum.github.io/orcid-cv](https://cmarcum.github.io/orcid-cv)

This is a work-in-progress, built as a proof-of-concept. Please feel free to contribute via issues or pull requests. 

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
