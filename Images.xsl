<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:f="http://hl7.org/fhir"
    exclude-result-prefixes="#all"
    version="2.0">
    <xsl:import href="buildResources.xsl"/>
    
    <xsl:output indent="yes" omit-xml-declaration="no"/>
        
    <xsl:param name="inputdir">input/</xsl:param>
    
    <xsl:variable name="instances" select="collection(concat($inputdir, 'examples/', '?select=*.xml;recurse=yes'))/f:*" as="item()*"/>
    <xsl:variable name="resources" select="collection(concat($inputdir, 'resources/', '?select=*.xml;recurse=yes'))/f:*" as="item()*"/>
    
    <xd:doc>
        <xd:desc/>
    </xd:doc>
    <xsl:template match="/">
        <xsl:message>Input dir   : <xsl:value-of select="$inputdir"/></xsl:message>
        
        <xsl:comment>Start by finding all references to "myig" and updating to appropriate text for your IG, including changing realm</xsl:comment>
        <ImplementationGuide xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://hl7.org/fhir https://build.fhir.org/fhir-all.xsd" xmlns="http://hl7.org/fhir">
            <id value="nictiz.fhir.nl.r4.images"/>
            <xsl:comment>&lt;extension url="http://hl7.org/fhir/tools/StructureDefinition/igpublisher-spreadsheet">
                &lt;valueString value="resources-spreadsheet.xml"/>
            &lt;/extension></xsl:comment>
            <url value="http://nictiz.nl/fhir/ImplementationGuide/nictiz.fhir.nl.r4.images"/>
            <xsl:comment>This version will propagate to all artifacts unless the "propagate-version" extension is overridden </xsl:comment>
            <version value="dev"/>
            <name value="Nictiz-R4-Images"/>
            <title value="Nictiz R4 Images"/>
            <status value="draft"/>
            <experimental value="false"/>
            <publisher value="Nictiz"/>
            <contact>
                <name value="Nictiz"/>
                <telecom>
                    <system value="url"/>
                    <value value="https://nictiz.nl"/>
                    <use value="work"/>
                </telecom>
                <telecom>
                    <system value="email"/>
                    <value value="mailto:info@nictiz.nl"/>
                    <use value="work"/>
                </telecom>
            </contact>
            <description value="A brief description of what MyIG is about (probably the same text as in your readme)"/>
            <jurisdiction>
                 <xsl:comment>This will drive SNOMED release used</xsl:comment> 
                <coding>
                    <system value="urn:iso:std:iso:3166"/>
                    <code value="NL"/>
                    <xsl:comment>This is the code for universal</xsl:comment>
                    <xsl:comment>&lt;system value="http://unstats.un.org/unsd/methods/m49/m49.htm"/>
                    &lt;code value="001"/></xsl:comment>
                </coding>
            </jurisdiction>
            <packageId value="nictiz.fhir.nl.r4.images"/>
             <xsl:comment>This should be changed to 'not-open-source' or another license if appropriate for non-HL7-published content</xsl:comment> 
            <license value="CC0-1.0"/>
             <xsl:comment>This is whatever FHIR version(s) the IG artifacts are targeting (not the version of this file, which should always be 'current release')</xsl:comment> 
            <fhirVersion value="4.0.1"/>
            <dependsOn>
                <uri value="http://nictiz.nl/fhir/ImplementationGuide/nictiz.fhir.nl.stu3.zib2017"/>
                <packageId value="nictiz.fhir.nl.stu3.zib2017"/>
                <version value="dev"/>
            </dependsOn>
            <definition>
                 <xsl:comment>You don't need to define any groupings. The IGPublisher will define them for you. You only need to do so if your IG is 'special' 
                     and it's inappropriate to use the defaults.  Feel free to provide feedback about the defaults...</xsl:comment> 
                
                <xsl:call-template name="createResources"/>
                
                <page>
                    <xsl:comment>The root will always be toc.html - the template will force it if you don't do it</xsl:comment> 
                    <nameUrl value="toc.html"/>
                    <title value="Table of Contents"/>
                    <generation value="html"/>
                    <page>
                        <nameUrl value="index.html"/>
                        <title value="Nictiz R4 Zib2020 Home Page"/>
                        <generation value="html"/>
                    </page>
                    <page>
                        <nameUrl value="background.html"/>
                        <title value="Background"/>
                        <generation value="html"/>
                    </page>
                    <page>
                        <nameUrl value="spec.html"/>
                        <title value="Detailed Specification"/>
                        <generation value="markdown"/>
                    </page>
                    <page>
                        <nameUrl value="downloads.html"/>
                        <title value="Useful Downloads"/>
                        <generation value="html"/>
                    </page>
                    <page>
                        <nameUrl value="changes.html"/>
                        <title value="IG Change History"/>
                        <generation value="html"/>
                    </page>
                </page>
                 <xsl:comment>copyright year is a mandatory parameter</xsl:comment>
                <parameter>
                    <code value="copyrightyear"/>
                    <value value="2020+"/>
                </parameter>
                <xsl:comment>releaselabel should be the ballot status for HL7-published IGs.</xsl:comment>
                <parameter>
                    <code value="releaselabel"/>
                    <value value="CI Build"/>
                </parameter>
                <parameter>
                    <code value="find-other-resources"/>
                    <value value="true"/>
                </parameter>
                <xsl:comment>List any URLs we purposely have in our set but do not match the guides preferred URL</xsl:comment>
                <xsl:for-each select="$resources[f:url[starts-with(@value, 'http://decor.nictiz.nl/fhir/')] | f:url[starts-with(@value, 'http://fhir.nl/fhir/')]]">
                    <xsl:sort select="f:url/@value"/>
                    <parameter>
                        <code value="special-url"/>
                        <value value="{f:url/@value}"/>
                    </parameter>
                </xsl:for-each>
                <xsl:comment>Uncomment one or more of these if you want to limit which syntaxes are supported or want to disable the display of mappings</xsl:comment>
                <xsl:comment>&lt;parameter>
                    &lt;code value="excludexml"/>
                    &lt;value value="true"/>
                &lt;/parameter></xsl:comment>
                <xsl:comment>&lt;parameter>
                    &lt;code value="excludejson"/>
                    &lt;value value="true"/>
                &lt;/parameter></xsl:comment>
                <xsl:comment>&lt;parameter>
                    &lt;code value="excludettl"/>
                    &lt;value value="true"/>
                &lt;/parameter></xsl:comment>
                <xsl:comment>&lt;parameter>
                    &lt;code value="excludemap"/>
                    &lt;value value="true"/>
                &lt;/parameter></xsl:comment>
            </definition>
        </ImplementationGuide>
    </xsl:template>
</xsl:stylesheet>