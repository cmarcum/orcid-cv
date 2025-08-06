<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:param name="show-journal-titles" select="'true'"/>
    <xsl:output method="html" indent="yes"/>

    <xsl:template match="/">
        <div class="cv-container">

            <!-- Header -->
            <header>
                <h1>
                    <xsl:value-of select="//*[local-name()='personal-details']/*[local-name()='given-names']"/>
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="//*[local-name()='personal-details']/*[local-name()='family-name']"/>
                </h1>
                <p class="orcid-id">
                    ORCID: <xsl:value-of select="//*[local-name()='orcid-identifier']/*[local-name()='path']"/>
                </p>
            </header>

            <!-- Education -->
            <xsl:if test="//*[local-name()='education-summary']">
            <section>
                <h2>Education</h2>
                <ul>
                    <xsl:for-each select="//*[local-name()='education-summary']">
                        <li>
                            <strong><xsl:value-of select="*[local-name()='organization']/*[local-name()='name']"/></strong>
                            (<xsl:value-of select="*[local-name()='organization']/*[local-name()='address']/*[local-name()='city']"/>)
                            <br/>
                            <xsl:value-of select="*[local-name()='role-title']"/>
                            <xsl:if test="*[local-name()='start-date']/*[local-name()='year']">
                                <xsl:text> • </xsl:text>
                                <xsl:value-of select="*[local-name()='start-date']/*[local-name()='year']"/>
                                <xsl:text> – </xsl:text>
                                <xsl:value-of select="*[local-name()='end-date']/*[local-name()='year']"/>
                            </xsl:if>
                        </li>
                    </xsl:for-each>
                </ul>
            </section>
            </xsl:if>

            <!-- Employment -->
            <xsl:if test="//*[local-name()='employment-summary']">
            <section>
                <h2>Employment</h2>
                <ul>
                    <xsl:for-each select="//*[local-name()='employment-summary']">
                        <li>
                            <strong><xsl:value-of select="*[local-name()='organization']/*[local-name()='name']"/></strong>
                            (<xsl:value-of select="*[local-name()='organization']/*[local-name()='address']/*[local-name()='city']"/>)
                            <br/>
                            <xsl:value-of select="*[local-name()='role-title']"/>
                            <xsl:if test="*[local-name()='start-date']/*[local-name()='year']">
                                <xsl:text> • </xsl:text>
                                <xsl:value-of select="*[local-name()='start-date']/*[local-name()='year']"/>
                                <xsl:text> – </xsl:text>
                                <xsl:value-of select="*[local-name()='end-date']/*[local-name()='year']"/>
                            </xsl:if>
                        </li>
                    </xsl:for-each>
                </ul>
            </section>
            </xsl:if>

            <!-- Service -->
            <xsl:if test="//*[local-name()='service-summary']">
            <section>
                <h2>Service</h2>
                <ul>
                    <xsl:for-each select="//*[local-name()='service-summary']">
                        <li>
                            <strong><xsl:value-of select="*[local-name()='organization']/*[local-name()='name']"/></strong>
                            (<xsl:value-of select="*[local-name()='organization']/*[local-name()='address']/*[local-name()='city']"/>)
                            <br/>
                            <xsl:value-of select="*[local-name()='role-title']"/>
                        </li>
                    </xsl:for-each>
                </ul>
            </section>
            </xsl:if>

            <!-- Distinctions -->
            <xsl:if test="//*[local-name()='distinction-summary']">
            <section>
                <h2>Distinctions</h2>
                <ul>
                    <xsl:for-each select="//*[local-name()='distinction-summary']">
                        <li>
                            <strong><xsl:value-of select="*[local-name()='title']"/></strong>
                            <xsl:if test="*[local-name()='organization']/*[local-name()='name']">
                                <xsl:text>, </xsl:text>
                                <xsl:value-of select="*[local-name()='organization']/*[local-name()='name']"/>
                            </xsl:if>
                            <xsl:if test="*[local-name()='start-date']/*[local-name()='year']">
                                <xsl:text> (</xsl:text>
                                <xsl:value-of select="*[local-name()='start-date']/*[local-name()='year']"/>
                                <xsl:text>)</xsl:text>
                            </xsl:if>
                        </li>
                    </xsl:for-each>
                </ul>
            </section>
            </xsl:if>

            <!-- Publications -->
            <xsl:if test="//*[local-name()='work-summary']">
            <section>
                <h2>Publications</h2>
                <ol>
                    <xsl:for-each select="//*[local-name()='work-summary']">
                        <li>
                            <xsl:variable name="doi" select="*[local-name()='external-ids']/*[local-name()='external-id'][*[local-name()='external-id-type']='doi']/*[local-name()='external-id-value']"/>
                            <xsl:variable name="journal" select="*[local-name()='journal-title']"/>

                            <xsl:choose>
                                <xsl:when test="$doi">
                                    <a target="_blank">
                                        <xsl:attribute name="href">
                                            <xsl:text>https://doi.org/</xsl:text>
                                            <xsl:value-of select="$doi"/>
                                        </xsl:attribute>
                                        <i><xsl:value-of select="*[local-name()='title']/*[local-name()='title']"/></i>
                                    </a>
                                </xsl:when>
                                <xsl:otherwise>
                                    <i><xsl:value-of select="*[local-name()='title']/*[local-name()='title']"/></i>
                                </xsl:otherwise>
                            </xsl:choose>

                            <xsl:if test="$show-journal-titles='true' and string-length($journal) &gt; 0">
                                <xsl:text>, </xsl:text>
                                <xsl:value-of select="$journal"/>
                            </xsl:if>

                            <xsl:if test="*[local-name()='publication-date']/*[local-name()='year']">
                                <xsl:text> (</xsl:text>
                                <xsl:value-of select="*[local-name()='publication-date']/*[local-name()='year']"/>
                                <xsl:text>)</xsl:text>
                            </xsl:if>
                        </li>
                    </xsl:for-each>
                </ol>
            </section>
            </xsl:if>

        </div>
    </xsl:template>
</xsl:stylesheet>
