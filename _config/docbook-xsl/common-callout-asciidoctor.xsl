<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <!--
        We want to use extensions for numerous things
     -->
    <!--
    <xsl:param name="use.extensions">1</xsl:param>
    -->

    <!--
        Callout support
    -->
    <xsl:param name="callouts.extension">1</xsl:param>
    <xsl:param name="callout.icon.size">9pt</xsl:param>
    <xsl:param name="callout.graphics">1</xsl:param>
    <xsl:param name="callout.graphics.number.limit">15</xsl:param>
    <xsl:param name="callout.graphics.extension">.png</xsl:param>

    <xsl:param name="callout.graphics.path">
        <xsl:if test="$img.src.path != ''">
            <xsl:value-of select="$img.src.path"/>
        </xsl:if>
        <xsl:text>images/community/docbook/callouts/</xsl:text>
    </xsl:param>

</xsl:stylesheet>
