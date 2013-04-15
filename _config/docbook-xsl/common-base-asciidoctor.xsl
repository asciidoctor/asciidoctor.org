<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:d="http://docbook.org/ns/docbook">

    <!--
        We want to use extensions for numerous things
     -->
    <xsl:param name="use.extensions">1</xsl:param>

    <!--
        We need to add this as it's needed later for a check
    -->
    <xsl:param name="confidential" select="0"/>

    <xsl:param name="asciidoc.mode">0</xsl:param>

    <xsl:param name="ulink.show" select="1"/>
    <xsl:param name="ulink.footnotes" select="1"/>
    <xsl:param name="runinhead.default.title.end.punct" select="''"/>

    <!--
        TOC
    -->
    <xsl:param name="chapter.autolabel">
        <xsl:choose>
            <xsl:when test="$asciidoc.mode = 0">1</xsl:when>
            <xsl:when test="/processing-instruction('asciidoc-numbered')">1</xsl:when>
            <xsl:otherwise>0</xsl:otherwise>
        </xsl:choose>
    </xsl:param>
    <xsl:param name="section.autolabel">
        <xsl:choose>
            <xsl:when test="$asciidoc.mode = 0">1</xsl:when>
            <xsl:when test="/processing-instruction('asciidoc-numbered')">1</xsl:when>
            <xsl:otherwise>0</xsl:otherwise>
        </xsl:choose>
    </xsl:param>
    <xsl:param name="section.autolabel.max.depth">
        <xsl:choose>
            <xsl:when test="$asciidoc.mode = 0">8</xsl:when>
            <xsl:otherwise>2</xsl:otherwise>
        </xsl:choose>
    </xsl:param>
    <xsl:param name="section.label.includes.component.label" select="1"/>

    <!--
        Enable line numbering extension.

        I have personally not gotten this to work yet
    -->
    <xsl:param name="linenumbering.extension">1</xsl:param>
    <xsl:param name="linenumbering.width">2</xsl:param>
    <xsl:param name="linenumbering.everyNth">1</xsl:param>

    <!--
        Admonition support
    -->
    <xsl:param name="admon.graphics" select="1"/>
    <xsl:param name="admon.graphics.path">
        <xsl:if test="$img.src.path != ''">
            <xsl:value-of select="$img.src.path"/>
        </xsl:if>
        <xsl:text>images/community/docbook/</xsl:text>
    </xsl:param>

</xsl:stylesheet>
