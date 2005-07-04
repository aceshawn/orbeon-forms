<!--
    Copyright (C) 2004 Orbeon, Inc.
  
    This program is free software; you can redistribute it and/or modify it under the terms of the
    GNU Lesser General Public License as published by the Free Software Foundation; either version
    2.1 of the License, or (at your option) any later version.
  
    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
    without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
    See the GNU Lesser General Public License for more details.
  
    The full text of the license is available at http://www.gnu.org/copyleft/lesser.html
-->
<p:config xmlns:p="http://www.orbeon.com/oxf/pipeline"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:oxf="http://www.orbeon.com/oxf/processors">

    <!-- Generate exception document -->
    <p:processor name="oxf:exception">
        <p:output name="data" id="exception"/>
    </p:processor>

    <!-- Format exception page -->
    <p:processor name="oxf:xslt">
        <p:input name="data" href="#exception"/>
        <p:input name="config">
            <xsl:stylesheet version="1.0" >
                <xsl:import href="oxf:/oxf/xslt/utils/utils.xsl"/>
                <xsl:template match="/">
                    <html xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns="http://www.w3.org/1999/xhtml">
                        <head>
                            <title>PresentationServer - Error Page</title>
                        </head>
                        <body>
                            <h1>PresentationServer - Error Page</h1>

                            <table class="gridtable">
                                <tr>
                                    <th>Type</th>
                                    <td>
                                        <xsl:value-of select="/exceptions/exception/type"/>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Message</th>
                                    <td>
                                        <xsl:call-template name="htmlize-line-breaks">
                                            <xsl:with-param name="text" select="replace(string(/exceptions/exception/message), ' ', '&#160;')"/>
                                        </xsl:call-template>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Location</th>
                                    <td>
                                        <xsl:value-of select="/exceptions/exception/system-id"/>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Line</th>
                                    <td>
                                        <xsl:choose>
                                            <xsl:when test="string(number(/exceptions/exception/line)) != 'NaN' and /exceptions/exception/line > 0">
                                                <xsl:value-of select="/exceptions/exception/line"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                N/A
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Column</th>
                                    <td>
                                        <xsl:choose>
                                            <xsl:when test="string(number(/exceptions/exception/column)) != 'NaN' and /exceptions/exception/column > 0">
                                                <xsl:value-of select="/exceptions/exception/column"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                N/A
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </td>
                                </tr>
                                <tr>
                                    <th valign="top">Stack Trace</th>
                                    <td>
                                        <xsl:choose>
                                            <xsl:when test="/exceptions/exception/stack-trace-elements">
                                                <table class="gridtable" width="100%">
                                                    <tr>
                                                        <th>Class Name</th>
                                                        <th>Method Name</th>
                                                        <th>File Name</th>
                                                        <th>Line Number</th>
                                                    </tr>
                                                    <xsl:for-each select="/exceptions/exception/stack-trace-elements/element">
                                                        <tr>
                                                            <td><xsl:value-of select="class-name"/></td>
                                                            <td><xsl:value-of select="method-name"/></td>
                                                            <td><xsl:value-of select="file-name"/></td>
                                                            <td>
                                                                <xsl:choose>
                                                                    <xsl:when test="string(number(line-number)) != 'NaN' and line-number > 0">
                                                                        <xsl:value-of select="line-number"/>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        N/A
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </td>
                                                        </tr>
                                                    </xsl:for-each>
                                                </table>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <code>
                                                    <xsl:value-of select="/exceptions/exception/stack-trace"/>
                                                </code>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </td>
                                </tr>
                            </table>

                        </body>
                    </html>
                </xsl:template>
                <xsl:template name="htmlize-line-breaks">
                    <xsl:param name="text"/>
                    <xsl:choose>
                        <xsl:when test="contains($text, '&#10;')">
                            <xsl:value-of select="substring-before($text, '&#10;')"/>
                            <br/>
                            <xsl:call-template name="htmlize-line-breaks">
                                <xsl:with-param name="text" select="substring-after($text, '&#10;')"/>
                            </xsl:call-template>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$text"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:template>
            </xsl:stylesheet>
        </p:input>
        <p:output name="data" id="document"/>
    </p:processor>

    <!-- Get some request information -->
    <p:processor name="oxf:request">
        <p:input name="config">
            <config>
                <include>/request/container-type</include>
                <include>/request/request-path</include>
            </config>
        </p:input>
        <p:output name="data" id="request"/>
    </p:processor>

    <!-- Apply theme -->
    <p:processor name="oxf:xslt">
        <p:input name="data" href="#document"/>
        <p:input name="request" href="#request"/>
        <p:input name="config" href="oxf:/config/theme/theme.xsl"/>
        <p:output name="data" id="themed"/>
    </p:processor>

    <!-- Rewrite all URLs in HTML and XHTML documents -->
    <p:processor name="oxf:unsafe-xslt">
        <p:input name="data" href="#themed"/>
        <p:input name="config" href="oxf:/ops/pfc/url-rewrite.xsl"/>
        <p:output name="data" id="rewritten-data"/>
    </p:processor>

    <!-- Convert to HTML -->
    <p:processor name="oxf:qname-converter">
        <p:input name="config">
            <config>
                <match>
                    <uri>http://www.w3.org/1999/xhtml</uri>
                </match>
                <replace>
                    <uri></uri>
                    <prefix></prefix>
                </replace>
            </config>
        </p:input>
        <p:input name="data" href="#rewritten-data"/>
        <p:output name="data" id="html-data"/>
    </p:processor>

    <p:processor name="oxf:html-converter">
        <p:input name="config">
            <config>
                <public-doctype>-//W3C//DTD HTML 4.01 Transitional//EN</public-doctype>
                <version>4.01</version>
                <encoding>utf-8</encoding>
            </config>
        </p:input>
        <p:input name="data" href="#html-data"/>
        <p:output name="data" id="converted"/>
    </p:processor>

    <!-- Serialize -->
    <p:processor name="oxf:http-serializer">
        <p:input name="config">
            <config>
                <status-code>500</status-code>
                <header>
                    <name>Cache-Control</name>
                    <value>post-check=0, pre-check=0</value>
                </header>
            </config>
        </p:input>
        <p:input name="data" href="#converted"/>
    </p:processor>

</p:config>
