<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- Need to grab this from the parser and carry forward SHOW_JOURNAL_TITLES -->
    <xsl:param name="show-journal-titles" select="'true'"/>
    <xsl:output method="html" indent="yes"/>
    <!-- Key for grouping by lowercase title -->
    <xsl:key name="by-title" match="*[local-name()='work-summary']"
        use="translate(normalize-space(*[local-name()='title']/*[local-name()='title']),'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')" />
    
    <xsl:template match="/">
        <div class="cv-container">

            <!-- TO_DO pull in person namespace and use credit-name for the title line -->
            <header>
                <h1>
                    <xsl:text> Curriculum Vitae of </xsl:text><xsl:value-of select="//*[local-name()='source']/*[local-name()='source-name']"/>  
                </h1>
                <p class="orcid-id">
                    <xsl:text> ORCID: </xsl:text> <xsl:value-of select="//*[local-name()='orcid-identifier']/*[local-name()='path']"/>
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
                            <br/>
                            <xsl:value-of select="*[local-name()='role-title']"/>, <xsl:value-of select="*[local-name()='department-name']"/>
                            <xsl:choose>
                                <xsl:when test="*[local-name()='start-date']/*[local-name()='year'] and *[local-name()='end-date']/*[local-name()='year']">
                                    <xsl:text> • </xsl:text>
                                    <xsl:value-of select="*[local-name()='start-date']/*[local-name()='year']"/>
                                    <xsl:text> – </xsl:text>
                                    <xsl:value-of select="*[local-name()='end-date']/*[local-name()='year']"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:text> • </xsl:text>
                                    <xsl:value-of select="*[local-name()='start-date']/*[local-name()='year']"/>
                                    <xsl:text> – Present </xsl:text>
                                </xsl:otherwise>
                            </xsl:choose>
                        </li>
                    </xsl:for-each>
                </ul>
            </section>
            </xsl:if>

            <!-- Distinctions -->
            <xsl:if test="//*[local-name()='distinction-summary']">
            <section>
                <h2>Distinctions & Invited Positions</h2>
                <ul>
                    <xsl:for-each select="//*[local-name()='distinction-summary'] | //*[local-name()='invited-position-summary']">
                    <!-- TO_DO: tune to sort by date -->
                    <!-- <xsl:sort select="number(*[local-name()='start-date']/*[local-name()='year'])" data-type="number" order="descending"/> -->
                        <li>
                            <strong><xsl:value-of select="*[local-name()='role-title']"/></strong>
                                <br/>
                            <xsl:if test="//*[local-name()='distinction-summary']">
                                <xsl:value-of select="*[local-name()='department-name']"/>
                                <xsl:text>, </xsl:text>
                            </xsl:if>
                            <xsl:value-of select="*[local-name()='organization']/*[local-name()='name']"/>
                            <xsl:if test="*[local-name()='start-date']/*[local-name()='year'] and *[local-name()='start-date']/*[local-name()='month']">
                                <xsl:text> (</xsl:text>
                                <xsl:value-of select="*[local-name()='start-date']/*[local-name()='month']"/><xsl:text>/</xsl:text><xsl:value-of select="*[local-name()='start-date']/*[local-name()='year']"/>
                                <xsl:text>)</xsl:text>
                            </xsl:if>
                        </li>
                    </xsl:for-each>
                </ul>
            </section>
            </xsl:if>

            <!-- Publications / Works etc With Deduplication (if we're lucky) -->
            <!-- A portion of the deduplication routine was AI-assisted because mine kept breaking-->
            <xsl:if test="//*[local-name()='work-summary']">
            <section>
                <h2>Works</h2>
                <ol>
                    <!-- Iterate unique titles only -->
                    <xsl:for-each select="
                        //*[local-name()='work-summary']
                        [generate-id() =
                         generate-id(key('by-title',
                           translate(normalize-space(*[local-name()='title']/*[local-name()='title']),
                                     'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')
                         )[1])]
                    ">
                        <xsl:variable name="title-lc"
                            select="translate(normalize-space(*[local-name()='title']/*[local-name()='title']),
                                              'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')" />
                        <xsl:variable name="title"
                            select="*[local-name()='title']/*[local-name()='title']"/>
            
                        <!-- All works with the same title -->
                        <xsl:variable name="dupes" select="key('by-title',$title-lc)" />
            
                        <!-- Sort duplicates by publication year ascending -->
                        <xsl:for-each select="$dupes">
                            <xsl:sort select="*[local-name()='publication-date']/*[local-name()='year']"
                                      data-type="number" order="ascending" />
                            <!-- Only the first (earliest) one -->
                            <xsl:if test="position()=1">
                                <li>
                                    <!-- Determine best link: DOI > URL > plain text -->
                                    <xsl:variable name="doi"
                                        select="*[local-name()='external-ids']/*[local-name()='external-id']
                                                [*[local-name()='external-id-type']='doi']
                                                /*[local-name()='external-id-value']"/>
                                    <xsl:variable name="url" select="*[local-name()='url']"/>
            
                                    <xsl:choose>
                                        <xsl:when test="$doi">
                                            <a target="_blank">
                                                <xsl:attribute name="href">
                                                    <xsl:text>https://doi.org/</xsl:text>
                                                    <xsl:value-of select="$doi"/>
                                                </xsl:attribute>
                                                <i><xsl:value-of select="$title"/></i>
                                            </a>
                                        </xsl:when>
                                        <xsl:when test="$url">
                                            <a target="_blank">
                                                <xsl:attribute name="href">
                                                    <xsl:value-of select="$url"/>
                                                </xsl:attribute>
                                                <i><xsl:value-of select="$title"/></i>
                                            </a>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <i><xsl:value-of select="$title"/></i>
                                        </xsl:otherwise>
                                    </xsl:choose>
            
                                    <xsl:if test="$show-journal-titles='true' and string-length(*[local-name()='journal-title']) &gt; 0">
                                        <xsl:text>, </xsl:text>
                                        <xsl:value-of select="*[local-name()='journal-title']"/>
                                    </xsl:if>
            
                                    <xsl:if test="*[local-name()='publication-date']/*[local-name()='year']">
                                        <xsl:text> (</xsl:text>
                                        <xsl:value-of select="*[local-name()='publication-date']/*[local-name()='year']"/>
                                        <xsl:text>)</xsl:text>
                                    </xsl:if>
                                </li>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:for-each>
                </ol>
            </section>
            </xsl:if>         
        </div>
    </xsl:template>
</xsl:stylesheet>
