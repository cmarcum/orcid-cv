// CONFIG
const ORCID_ID = '0000-0002-0899-6143'; // Your ORCID ID goes here
const SHOW_JOURNAL_TITLES = true; // set this to true to show journal titles and false to help change the world

async function loadORCIDCV() {
    const xmlUrl = `https://pub.orcid.org/v3.0/${ORCID_ID}/record`;
    const xslUrl = 'orcid-to-cv.xsl';

    const [xmlResp, xslResp] = await Promise.all([
        fetch(xmlUrl, { headers: { Accept: 'application/xml' } }),
        fetch(xslUrl)
    ]);

    const xmlText = await xmlResp.text();
    const xslText = await xslResp.text();

    const parser = new DOMParser();
    const xml = parser.parseFromString(xmlText, 'application/xml');
    const xsl = parser.parseFromString(xslText, 'application/xml');

    const xsltProcessor = new XSLTProcessor();
    xsltProcessor.importStylesheet(xsl);

    // are we showing journal titles or are we changing the world?
    xsltProcessor.setParameter(null, 'show-journal-titles', SHOW_JOURNAL_TITLES ? 'true' : 'false');

    const resultDocument = xsltProcessor.transformToFragment(xml, document);
    const root = document.getElementById('cv-root');
    root.innerHTML = ''; // Clear loading text in index.html
    root.appendChild(resultDocument);
}

loadORCIDCV();