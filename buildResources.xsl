<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:f="http://hl7.org/fhir"
    exclude-result-prefixes="#all"
    version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> May 28, 2017</xd:p>
            <xd:p><xd:b>Author:</xd:b> ahenket</xd:p>
            <xd:p></xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:output indent="yes" omit-xml-declaration="no"/>    
    <xsl:param name="inputdir">input/</xsl:param>    
    <xsl:variable name="instances" select="collection(concat($inputdir, 'examples/', '?select=*.xml;recurse=yes'))/f:*" as="item()*"/>
    <xsl:variable name="resources" select="collection(concat($inputdir, 'resources/', '?select=*.xml;recurse=yes'))/f:*" as="item()*"/>    
    <xd:doc>
        <xd:desc/>
    </xd:doc>
    <xsl:template name="createResources">
        <xsl:for-each-group select="$resources" group-by="local-name()">
            <xsl:sort select="local-name()"/>
            <xsl:sort select="f:name/@value"/>
            <xsl:variable name="resourceType" select="local-name(.)" as="xs:string"/>
            
            <xsl:for-each select="current-group()[current-grouping-key() = ('ConceptMap', 'NamingSystem', 'OperationDefinition', 'SearchParameter')]">
                <xsl:variable name="resourceId" select="f:id/@value" as="xs:string"/>
                <resource xmlns="http://hl7.org/fhir">
                    <reference>
                        <reference value="{$resourceType}/{$resourceId}"/>
                    </reference>
                    <name value="{$resourceType, (f:title/@value, f:name/@value)[1]}"/>
                    <!--<xsl:if test="not(empty($resourceProfile))">
                        <exampleCanonical value="{$resourceProfile}"/>
                    </xsl:if>-->
                </resource>
            </xsl:for-each>
        </xsl:for-each-group>
        <xsl:for-each select="$instances">
            <xsl:sort select="(f:meta/f:profile/@value, f:name/@value)[1]"/>
            <xsl:variable name="resourceId" select="f:id/@value" as="xs:string"/>
            <xsl:variable name="resourceType" select="local-name(.)" as="xs:string"/>
            <xsl:variable name="resourceProfile" select="f:meta/f:profile/@value" as="xs:string?"/>            
            <xsl:choose>
                <xsl:when test="empty($resourceProfile) or $resourceProfile = $resources[self::f:StructureDefinition]/f:url/@value">
                    <resource xmlns="http://hl7.org/fhir">
                        <reference>
                            <reference value="{$resourceType}/{$resourceId}"/>
                        </reference>
                        <name value="{$resourceType} example {$resourceId}"/>
                        <description value="TODO - {f:name/@value} ({tokenize($resourceProfile, '/')[last()]})"/>
                        <xsl:if test="not(empty($resourceProfile))">
                            <exampleCanonical value="{$resourceProfile}"/>
                        </xsl:if>
                    </resource>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:comment>
                        <xsl:text>&lt;resource>&#10;</xsl:text>
                        <xsl:text>            &lt;reference>&#10;</xsl:text>
                        <xsl:text>                &lt;reference value="</xsl:text>
                        <xsl:value-of select="$resourceType"/>
                        <xsl:text>/</xsl:text>
                        <xsl:value-of select="$resourceId"/>
                        <xsl:text>"/>&#10;</xsl:text>
                        <xsl:text>            &lt;/reference>&#10;</xsl:text>
                        <xsl:text>            &lt;name value="</xsl:text>
                        <xsl:value-of select="$resourceType"/>
                        <xsl:text> example </xsl:text>
                        <xsl:value-of select="$resourceId"/>
                        <xsl:text>"/>&#10;</xsl:text>
                        <xsl:text>            &lt;description value="TODO - </xsl:text>
                        <xsl:value-of select="f:name/@value"/>
                        <xsl:text> (</xsl:text>
                        <xsl:value-of select="tokenize($resourceProfile, '/')[last()]"/>
                        <xsl:text>)"/>&#10;</xsl:text>
                        <xsl:if test="not(empty($resourceProfile))">
                            <xsl:text>            &lt;exampleCanonical value="</xsl:text>
                            <xsl:value-of select="$resourceProfile"/>
                            <xsl:text>"/>&#10;</xsl:text>
                        </xsl:if>
                        <xsl:text>      &lt;/resource></xsl:text>
                    </xsl:comment>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>