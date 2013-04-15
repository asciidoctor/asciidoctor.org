<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:d="http://docbook.org/ns/docbook"
                xmlns:jbh="java:org.jboss.highlight.renderer.FORenderer"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="jbh">

    <!-- IMPORTS -->
    <xsl:import href="http://docbook.sourceforge.net/release/xsl/1.76.1/fo/docbook.xsl"/>


    <!-- INCLUDES -->
    <xsl:include href="common-base-asciidoctor.xsl"/>
    <xsl:include href="common-callout-asciidoctor.xsl"/>

    <!--
        FO/FOP extensions
    -->
    <xsl:param name="fop.extensions" select="1"/>
    <xsl:param name="fop1.extensions" select="0"/>

    <xsl:param name="l10n.gentext.default.language">en</xsl:param>

    <xsl:param name="line-height" select="1.5"/>
    <xsl:param name="alignment">justify</xsl:param>
    <!--
    <xsl:param name="chapter.autolabel" select="'A'"/>
    -->

    <!--
        ###########################################################################################
        Font support
        ###########################################################################################
    -->
    <xsl:template name="pickfont">
        <xsl:variable name="font">
            <xsl:choose>
                <xsl:when test="$l10n.gentext.language = 'ja-JP' or l10n.gentext.language = 'ja'">
                    <xsl:text>Sazanami Gothic,</xsl:text>
                </xsl:when>
                <xsl:when test="$l10n.gentext.language = 'ko-KR' or $l10n.gentext.language = 'ko'">
                    <xsl:text>Baekmuk Batang,</xsl:text>
                </xsl:when>
                <xsl:when test="$l10n.gentext.language = 'zh-CN'">
                    <xsl:text>ZYSong18030,AR PL UMing CN,</xsl:text>
                </xsl:when>
                <xsl:when test="$l10n.gentext.language = 'as-IN' or $l10n.gentext.language = 'as'">
                    <xsl:text>Lohit Bengali,</xsl:text>
                </xsl:when>
                <xsl:when test="$l10n.gentext.language = 'bn-IN' or $l10n.gentext.language = 'bn'">
                    <xsl:text>Lohit Bengali,</xsl:text>
                </xsl:when>
                <xsl:when test="$l10n.gentext.language = 'ta-IN' or $l10n.gentext.language = 'ta'">
                    <xsl:text>Lohit Tamil,</xsl:text>
                </xsl:when>
                <xsl:when test="$l10n.gentext.language = 'pa-IN' or l10n.gentext.language = 'pa'">
                    <xsl:text>Lohit Punjabi,</xsl:text>
                </xsl:when>
                <xsl:when test="$l10n.gentext.language = 'hi-IN' or $l10n.gentext.language = 'hi'">
                    <xsl:text>Lohit Hindi,</xsl:text>
                </xsl:when>
                <xsl:when test="$l10n.gentext.language = 'mr-IN' or $l10n.gentext.language = 'mr'">
                    <xsl:text>Lohit Hindi,</xsl:text>
                </xsl:when>
                <xsl:when test="$l10n.gentext.language = 'gu-IN' or $l10n.gentext.language = 'gu'">
                    <xsl:text>Lohit Gujarati,</xsl:text>
                </xsl:when>
                <xsl:when test="$l10n.gentext.language = 'zh-TW'">
                    <xsl:text>AR PL ShanHeiSun Uni,AR PL UMing TW,</xsl:text>
                </xsl:when>
                <xsl:when test="$l10n.gentext.language = 'kn-IN' or $l10n.gentext.language = 'kn'">
                    <xsl:text>Lohit Kannada,</xsl:text>
                </xsl:when>
                <xsl:when test="$l10n.gentext.language = 'ml-IN' or $l10n.gentext.language = 'ml-IN'">
                    <xsl:text>Lohit Malayalam,</xsl:text>
                </xsl:when>
                <xsl:when test="$l10n.gentext.language = 'or-IN' or $l10n.gentext.language = 'or'">
                    <xsl:text>Lohit Oriya,</xsl:text>
                </xsl:when>
                <xsl:when test="$l10n.gentext.language = 'te-IN' or $l10n.gentext.language = 'te'">
                    <xsl:text>Lohit Telugu,</xsl:text>
                </xsl:when>
                <xsl:when test="$l10n.gentext.language = 'si-LK' or $l10n.gentext.language = 'si'">
                    <xsl:text>LKLUG,</xsl:text>
                </xsl:when>
            </xsl:choose>
        </xsl:variable>

        <xsl:message>
            <xsl:text>pickfont selection [lang=</xsl:text><xsl:value-of select="$l10n.gentext.language"/><xsl:text>] : </xsl:text>
            <xsl:copy-of select="$font"/>
        </xsl:message>

        <xsl:copy-of select="$font"/>
    </xsl:template>

    <xsl:template name="pickfont-sans">
        <xsl:variable name="font">
            <xsl:call-template name="pickfont"/>
        </xsl:variable>

        <xsl:copy-of select="$font"/>
        <xsl:text>Helvetica,sans-serif</xsl:text>
    </xsl:template>

    <xsl:template name="pickfont-serif">
        <xsl:variable name="font">
            <xsl:call-template name="pickfont"/>
        </xsl:variable>

        <xsl:copy-of select="$font"/>
        <xsl:text>Georgia,serif</xsl:text>
    </xsl:template>

    <xsl:template name="pickfont-mono">
        <xsl:variable name="font">
            <xsl:call-template name="pickfont"/>
        </xsl:variable>

        <xsl:copy-of select="$font"/>
        <xsl:text>Liberation Mono,monospace</xsl:text>
    </xsl:template>

    <xsl:param name="title.font.family">
        <xsl:call-template name="pickfont-serif"/>
    </xsl:param>

    <xsl:param name="body.font.family">
        <xsl:call-template name="pickfont-sans"/>
    </xsl:param>

    <xsl:param name="monospace.font.family">
        <xsl:call-template name="pickfont-mono"/>
    </xsl:param>

    <xsl:param name="sans.font.family">
        <xsl:call-template name="pickfont-sans"/>
    </xsl:param>

    <!--
    <xsl:attribute-set name="formal.title.properties" use-attribute-sets="normal.para.spacing">
      <xsl:attribute name="font-weight">bold</xsl:attribute>
      <xsl:attribute name="color">#8F2C1D</xsl:attribute>
      <xsl:attribute name="font-size">
        <xsl:value-of select="$body.font.master * 1.2"></xsl:value-of>
        <xsl:text>pt</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="hyphenate">false</xsl:attribute>
      <xsl:attribute name="space-after.minimum">0.4em</xsl:attribute>
      <xsl:attribute name="space-after.optimum">0.6em</xsl:attribute>
      <xsl:attribute name="space-after.maximum">0.8em</xsl:attribute>
    </xsl:attribute-set>
    -->

    <xsl:attribute-set name="xref.properties">
        <xsl:attribute name="color">#005498</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="simple.xlink.properties">
        <xsl:attribute name="color">#005498</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="monospace.properties">
        <xsl:attribute name="font-family">
            <xsl:value-of select="$monospace.font.family"/>
        </xsl:attribute>
    </xsl:attribute-set>

    <xsl:param name="programlisting.font" select="$monospace.font.family"/>
    <xsl:param name="programlisting.font.size" select="'9pt'"/>


    <!--
        ###########################################################################################
        Page layout
        ###########################################################################################
    -->
    <xsl:param name="paper.type" select="'A4'"/>
    <xsl:param name="headers.on.blank.pages">1</xsl:param>
    <xsl:param name="footers.on.blank.pages">1</xsl:param>
    <xsl:param name="page.margin.top">15mm</xsl:param>
    <xsl:param name="region.before.extent">10mm</xsl:param>
    <xsl:param name="body.margin.top">15mm</xsl:param>
    <xsl:param name="body.margin.bottom">15mm</xsl:param>
    <xsl:param name="region.after.extent">10mm</xsl:param>
    <xsl:param name="page.margin.bottom">15mm</xsl:param>
    <xsl:param name="page.margin.outer">30mm</xsl:param>
    <xsl:param name="page.margin.inner">30mm</xsl:param>

    <!-- Make examples, tables etc. break across pages -->
    <xsl:attribute-set name="formal.object.properties">
        <xsl:attribute name="keep-together.within-column">auto</xsl:attribute>
    </xsl:attribute-set>


    <xsl:attribute-set name="example.properties" use-attribute-sets="formal.object.properties">
        <xsl:attribute name="border-width">.3mm</xsl:attribute>
        <xsl:attribute name="border-style">solid</xsl:attribute>
        <xsl:attribute name="border-color">#CCC</xsl:attribute>
        <xsl:attribute name="background-color">#FEFBF8</xsl:attribute>
        <xsl:attribute name="padding-top">0pt</xsl:attribute>
        <xsl:attribute name="padding-right">12pt</xsl:attribute>
        <xsl:attribute name="padding-bottom">12pt</xsl:attribute>
        <xsl:attribute name="padding-left">12pt</xsl:attribute>
        <xsl:attribute name="space-after.minimum">1em</xsl:attribute>
        <xsl:attribute name="space-after.optimum">1.5em</xsl:attribute>
        <xsl:attribute name="space-after.maximum">2em</xsl:attribute>
    </xsl:attribute-set>

    <!--
        ###########################################################################################
        Titles
        ###########################################################################################
    -->
    <xsl:param name="body.start.indent">0pt</xsl:param>
    <xsl:param name="title.color">#BA3925</xsl:param>
    <xsl:param name="chapter.title.color" select="$title.color"/>
    <xsl:param name="section.title.color" select="$title.color"/>

    <xsl:attribute-set name="section.title.level1.properties">
        <xsl:attribute name="color">
            <xsl:value-of select="$section.title.color"/>
        </xsl:attribute>
        <xsl:attribute name="font-size">
            <xsl:value-of select="$body.font.master * 1.6"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="section.title.level2.properties">
        <xsl:attribute name="color">
            <xsl:value-of select="$section.title.color"/>
        </xsl:attribute>
        <xsl:attribute name="font-size">
            <xsl:value-of select="$body.font.master * 1.4"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="section.title.level3.properties">
        <xsl:attribute name="color">
            <xsl:value-of select="$section.title.color"/>
        </xsl:attribute>
        <xsl:attribute name="font-size">
            <xsl:value-of select="$body.font.master * 1.3"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="section.title.level4.properties">
        <xsl:attribute name="color">
            <xsl:value-of select="$section.title.color"/>
        </xsl:attribute>
        <xsl:attribute name="font-size">
            <xsl:value-of select="$body.font.master * 1.2"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="section.title.level5.properties">
        <xsl:attribute name="color">
            <xsl:value-of select="$section.title.color"/>
        </xsl:attribute>
        <xsl:attribute name="font-size">
            <xsl:value-of select="$body.font.master * 1.1"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="section.title.level6.properties">
        <xsl:attribute name="color">
            <xsl:value-of select="$section.title.color"/>
        </xsl:attribute>
        <xsl:attribute name="font-size">
            <xsl:value-of select="$body.font.master"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="section.title.properties">
        <xsl:attribute name="font-family">
            <xsl:value-of select="$title.font.family"/>
        </xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <!-- font size is calculated dynamically by section.heading template -->
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
        <xsl:attribute name="space-before.minimum">0.8em</xsl:attribute>
        <xsl:attribute name="space-before.optimum">1.0em</xsl:attribute>
        <xsl:attribute name="space-before.maximum">1.2em</xsl:attribute>
        <xsl:attribute name="text-align">left</xsl:attribute>
        <xsl:attribute name="start-indent">
            <xsl:value-of select="$title.margin.left"/>
        </xsl:attribute>
    </xsl:attribute-set>

    <xsl:param name="formal.title.placement">
        figure after example before equation before table before procedure before
    </xsl:param>


    <!--
        ###########################################################################################
        TOC support
        ###########################################################################################
    -->
    <xsl:param name="generate.toc">
        <xsl:choose>
            <xsl:when test="$asciidoc.mode = 0">
set toc
book toc
article toc
            </xsl:when>
            <xsl:when test="/processing-instruction('asciidoc-toc')">
article toc,title
book    toc,title,figure,table,example,equation
                <xsl:if test="$generate.section.toc.level != 0">
chapter   toc,title
part      toc,title
preface   toc,title
qandadiv  toc
qandaset  toc
reference toc,title
sect1     toc
sect2     toc
sect3     toc
sect4     toc
sect5     toc
section   toc
set       toc,title
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
article nop
book    nop
            </xsl:otherwise>
        </xsl:choose>
    </xsl:param>

    <xsl:param name="toc.section.depth">2</xsl:param>

    <xsl:template name="toc.line">
        <xsl:variable name="id">
            <xsl:call-template name="object.id"/>
        </xsl:variable>

        <xsl:variable name="label">
            <xsl:apply-templates select="." mode="label.markup"/>
        </xsl:variable>

        <fo:block text-align-last="justify" end-indent="{$toc.indent.width}pt"
                  last-line-end-indent="-{$toc.indent.width}pt">
            <fo:inline keep-with-next.within-line="always">
                <fo:basic-link internal-destination="{$id}" color="#005498">

                    <!-- Chapter titles should be bold. -->
                    <!--
                    <xsl:choose>
                        <xsl:when test="local-name(.) = 'chapter'">
                            <xsl:attribute name="font-weight">bold</xsl:attribute>
                        </xsl:when>
                    </xsl:choose>
                    -->

                    <xsl:if test="$label != ''">
                        <!--
                        <xsl:value-of select="'Chapter '"/>
                        -->
                        <xsl:copy-of select="$label"/>
                        <xsl:value-of select="$autotoc.label.separator"/>
                    </xsl:if>
                    <xsl:apply-templates select="." mode="titleabbrev.markup"/>
                </fo:basic-link>
            </fo:inline>
            <fo:inline keep-together.within-line="always">
                <xsl:text> </xsl:text>
                <fo:leader leader-pattern="dots" leader-pattern-width="3pt"
                           leader-alignment="reference-area"
                           keep-with-next.within-line="always"/>
                <xsl:text> </xsl:text>
                <fo:basic-link internal-destination="{$id}" color="#005498">
                    <fo:page-number-citation ref-id="{$id}"/>
                </fo:basic-link>
            </fo:inline>
        </fo:block>
    </xsl:template>


    <!--
        ###########################################################################################
        Title page support
        ###########################################################################################
    -->
    <xsl:param name="editedby.enabled">0</xsl:param>
    <xsl:param name="titlepage.color" select="$title.color"/>

    <xsl:attribute-set name="book.titlepage.recto.style">
        <xsl:attribute name="font-family">
            <xsl:value-of select="$title.fontset"/>
        </xsl:attribute>
        <xsl:attribute name="color">
            <xsl:value-of select="$titlepage.color"/>
        </xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="font-size">12pt</xsl:attribute>
        <xsl:attribute name="text-align">center</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="component.title.properties">
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
        <xsl:attribute name="space-before.optimum">
            <xsl:value-of select="concat($body.font.master, 'pt')"/>
        </xsl:attribute>
        <xsl:attribute name="space-before.minimum">
            <xsl:value-of select="concat($body.font.master, 'pt')"/>
        </xsl:attribute>
        <xsl:attribute name="space-before.maximum">
            <xsl:value-of select="concat($body.font.master, 'pt')"/>
        </xsl:attribute>
        <xsl:attribute name="hyphenate">false</xsl:attribute>
        <xsl:attribute name="color">
            <xsl:choose>
                <xsl:when test="not(parent::d:chapter | parent::d:article | parent::d:appendix)">
                    <xsl:value-of select="$title.color"/>
                </xsl:when>
            </xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="text-align">
            <xsl:choose>
                <xsl:when
                        test="((parent::d:article | parent::d:articleinfo) and not(ancestor::d:book) and not(self::d:bibliography)) or (parent::d:slides | parent::d:slidesinfo)">
                    center
                </xsl:when>
                <xsl:otherwise>left</xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="start-indent">
            <xsl:value-of select="$title.margin.left"/>
        </xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="chapter.titlepage.recto.style">
        <xsl:attribute name="color">
            <xsl:value-of select="$chapter.title.color"/>
        </xsl:attribute>
        <xsl:attribute name="background-color">white</xsl:attribute>
        <xsl:attribute name="font-size">
            <xsl:choose>
                <xsl:when test="$l10n.gentext.language = 'ja-JP'">
                    <xsl:value-of select="$body.font.master * 1.7"/>
                    <xsl:text>pt</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>24pt</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="text-align">left</xsl:attribute>
        <!--xsl:attribute name="wrap-option">no-wrap</xsl:attribute-->
        <xsl:attribute name="padding-left">1em</xsl:attribute>
        <xsl:attribute name="padding-right">1em</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="preface.titlepage.recto.style" use-attribute-sets="chapter.titlepage.recto.style">
        <xsl:attribute name="font-family">
            <xsl:value-of select="$title.fontset"/>
        </xsl:attribute>
<!--
        <xsl:attribute name="color">#4a5d75</xsl:attribute>
        <xsl:attribute name="font-size">12pt</xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
-->
    </xsl:attribute-set>

    <xsl:attribute-set name="part.titlepage.recto.style">
        <xsl:attribute name="color">
            <xsl:value-of select="$title.color"/>
        </xsl:attribute>
        <xsl:attribute name="text-align">center</xsl:attribute>
    </xsl:attribute-set>



    <!--
        ###########################################################################################
        Footnote support
        ###########################################################################################
    -->
    <xsl:param name="footnote.font.size">
        <xsl:value-of select="$body.font.master * 0.8"/><xsl:text>pt</xsl:text>
    </xsl:param>
    <xsl:param name="footnote.number.format" select="'1'"/>
    <xsl:param name="footnote.number.symbols" select="''"/>
    <xsl:attribute-set name="footnote.mark.properties">
        <xsl:attribute name="font-size">85%</xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="font-style">normal</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="footnote.properties">
        <xsl:attribute name="padding-top">48pt</xsl:attribute>
        <xsl:attribute name="font-family">
            <xsl:value-of select="$body.fontset"/>
        </xsl:attribute>
        <xsl:attribute name="font-size">
            <xsl:value-of select="$footnote.font.size"/>
        </xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="font-style">normal</xsl:attribute>
        <xsl:attribute name="text-align">
            <xsl:value-of select="$alignment"/>
        </xsl:attribute>
        <xsl:attribute name="start-indent">0pt</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="footnote.sep.leader.properties">
        <xsl:attribute name="color">black</xsl:attribute>
        <xsl:attribute name="leader-pattern">rule</xsl:attribute>
        <xsl:attribute name="leader-length">1in</xsl:attribute>
    </xsl:attribute-set>


    <!--
        ###########################################################################################
        Admonition support
        ###########################################################################################
    -->
    <xsl:param name="admon.graphics.extension" select="'.svg'"/>

    <xsl:attribute-set name="admonition.title.properties">
        <xsl:attribute name="font-size">13pt</xsl:attribute>
        <xsl:attribute name="color">
            <xsl:choose>
                <xsl:when test="self::d:note">#4C5253</xsl:when>
                <xsl:when test="self::d:caution">#533500</xsl:when>
                <xsl:when test="self::d:important">white</xsl:when>
                <xsl:when test="self::d:warning">white</xsl:when>
                <xsl:when test="self::d:tip">white</xsl:when>
                <xsl:otherwise>white</xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>

        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="hyphenate">false</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>

    </xsl:attribute-set>

    <xsl:attribute-set name="graphical.admonition.properties">

        <xsl:attribute name="color">
            <xsl:choose>
                <xsl:when test="self::d:note">#4C5253</xsl:when>
                <xsl:when test="self::d:caution">#533500</xsl:when>
                <xsl:when test="self::d:important">white</xsl:when>
                <xsl:when test="self::d:warning">white</xsl:when>
                <xsl:when test="self::d:tip">white</xsl:when>
                <xsl:otherwise>white</xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="background-color">
            <xsl:choose>
                <xsl:when test="self::d:note">#B5BCBD</xsl:when>
                <xsl:when test="self::d:caution">#E3A835</xsl:when>
                <xsl:when test="self::d:important">#4A5D75</xsl:when>
                <xsl:when test="self::d:warning">#7B1E1E</xsl:when>
                <xsl:when test="self::d:tip">#7E917F</xsl:when>
                <xsl:otherwise>#404040</xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>

        <xsl:attribute name="space-before.optimum">1em</xsl:attribute>
        <xsl:attribute name="space-before.minimum">0.8em</xsl:attribute>
        <xsl:attribute name="space-before.maximum">1.2em</xsl:attribute>
        <xsl:attribute name="space-after.optimum">1em</xsl:attribute>
        <xsl:attribute name="space-after.minimum">0.8em</xsl:attribute>
        <xsl:attribute name="space-after.maximum">1em</xsl:attribute>
        <xsl:attribute name="padding-bottom">12pt</xsl:attribute>
        <xsl:attribute name="padding-top">12pt</xsl:attribute>
        <xsl:attribute name="padding-right">12pt</xsl:attribute>
        <xsl:attribute name="padding-left">12pt</xsl:attribute>
        <xsl:attribute name="margin-left">
            <xsl:value-of select="$title.margin.left"/>
        </xsl:attribute>
    </xsl:attribute-set>


    <!--
        ###########################################################################################
        Images
        ###########################################################################################
    -->
    <xsl:param name="img.src.path"/>
    <!-- scalefit for large images -->
    <xsl:param name="graphicsize.extension" select="'1'"/>
    <xsl:param name="default.image.width">17.4cm</xsl:param>
    <xsl:param name="default.inline.image.height">1em</xsl:param>

    <!--
        From: fo/graphics.xsl
        Reason: Scale PDF images down to fit the page
                (content-width="scale-down-to-fit" content-height="scale-down-to-fit").
        Version: 1.76.1
    -->
    <xsl:template name="process.image">
        <!-- When this template is called, the current node should be -->
        <!-- a graphic, inlinegraphic, imagedata, or videodata. All -->
        <!-- those elements have the same set of attributes, so we can -->
        <!-- handle them all in one place. -->

        <xsl:variable name="scalefit">
            <xsl:choose>
                <xsl:when test="$ignore.image.scaling != 0">0</xsl:when>
                <xsl:when test="@contentwidth">0</xsl:when>
                <xsl:when test="@contentdepth and @contentdepth != '100%'">0
                </xsl:when>
                <xsl:when test="@scale">0</xsl:when>
                <xsl:when test="@scalefit">
                    <xsl:value-of select="@scalefit"/>
                </xsl:when>
                <xsl:when test="@width or @depth">1</xsl:when>
                <xsl:otherwise>0</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="scale">
            <xsl:choose>
                <xsl:when test="$ignore.image.scaling != 0">0</xsl:when>
                <xsl:when test="@contentwidth or @contentdepth">1.0</xsl:when>
                <xsl:when test="@scale">
                    <xsl:value-of select="@scale div 100.0"/>
                </xsl:when>
                <xsl:otherwise>1.0</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="filename">
            <xsl:choose>
                <xsl:when test="local-name(.) = 'graphic' or local-name(.) = 'inlinegraphic'">
                    <!-- handle legacy graphic and inlinegraphic by new template -->
                    <xsl:call-template name="mediaobject.filename">
                        <xsl:with-param name="object" select="."/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <!-- imagedata, videodata, audiodata -->
                    <xsl:call-template name="mediaobject.filename">
                        <xsl:with-param name="object" select=".."/>
                    </xsl:call-template>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="content-type">
            <xsl:if test="@format">
                <xsl:call-template name="graphic.format.content-type">
                    <xsl:with-param name="format" select="@format"/>
                </xsl:call-template>
            </xsl:if>
        </xsl:variable>

        <xsl:variable name="bgcolor">
            <xsl:call-template name="pi.dbfo_background-color">
                <xsl:with-param name="node" select=".."/>
            </xsl:call-template>
        </xsl:variable>

        <fo:external-graphic>
            <xsl:attribute name="src">
                <xsl:call-template name="fo-external-image">
                    <xsl:with-param name="filename">
                        <xsl:if test="$img.src.path != '' and not(starts-with($filename, '/')) and not(contains($filename, '://'))">
                            <xsl:value-of select="$img.src.path"/>
                        </xsl:if>
                        <xsl:value-of select="$filename"/>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:attribute>

            <xsl:attribute name="width">
                <xsl:choose>
                    <xsl:when test="$ignore.image.scaling != 0">auto</xsl:when>
                    <xsl:when test="contains(@width,'%')">
                        <xsl:value-of select="@width"/>
                    </xsl:when>
                    <xsl:when test="@width and not(@width = '')">
                        <xsl:call-template name="length-spec">
                            <xsl:with-param name="length" select="@width"/>
                            <xsl:with-param name="default.units" select="'px'"/>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:when test="not(@depth) and not(ancestor::inlinemediaobject) and $default.image.width != ''">
                        <xsl:call-template name="length-spec">
                            <xsl:with-param name="length" select="$default.image.width"/>
                            <xsl:with-param name="default.units" select="'px'"/>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:otherwise>auto</xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>

            <xsl:attribute name="height">
                <xsl:choose>
                    <xsl:when test="$ignore.image.scaling != 0">auto</xsl:when>
                    <xsl:when test="contains(@depth,'%')">
                        <xsl:value-of select="@depth"/>
                    </xsl:when>
                    <xsl:when test="@depth">
                        <xsl:call-template name="length-spec">
                            <xsl:with-param name="length" select="@depth"/>
                            <xsl:with-param name="default.units" select="'px'"/>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:when test="ancestor::inlinemediaobject">
                        <xsl:call-template name="length-spec">
                            <xsl:with-param name="length" select="$default.inline.image.height"/>
                            <xsl:with-param name="default.units" select="'px'"/>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:otherwise>auto</xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>

            <xsl:attribute name="content-width">
                <xsl:choose>
                    <xsl:when test="$ignore.image.scaling != 0">auto</xsl:when>
                    <xsl:when test="contains(@contentwidth,'%')">
                        <xsl:value-of select="@contentwidth"/>
                    </xsl:when>
                    <xsl:when test="@contentwidth">
                        <xsl:call-template name="length-spec">
                            <xsl:with-param name="length" select="@contentwidth"/>
                            <xsl:with-param name="default.units" select="'px'"/>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:when test="number($scale) != 1.0">
                        <xsl:value-of select="$scale * 100"/>
                        <xsl:text>%</xsl:text>
                    </xsl:when>
                    <xsl:when test="$scalefit = 1">scale-to-fit</xsl:when>
                    <xsl:otherwise>scale-down-to-fit</xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>

            <xsl:attribute name="content-height">
                <xsl:choose>
                    <xsl:when test="$ignore.image.scaling != 0">auto</xsl:when>
                    <xsl:when test="contains(@contentdepth,'%')">
                        <xsl:value-of select="@contentdepth"/>
                    </xsl:when>
                    <xsl:when test="@contentdepth">
                        <xsl:call-template name="length-spec">
                            <xsl:with-param name="length" select="@contentdepth"/>
                            <xsl:with-param name="default.units" select="'px'"/>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:when test="number($scale) != 1.0">
                        <xsl:value-of select="$scale * 100"/>
                        <xsl:text>%</xsl:text>
                    </xsl:when>
                    <xsl:when test="$scalefit = 1">scale-to-fit</xsl:when>
                    <xsl:otherwise>scale-down-to-fit</xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>

            <xsl:if test="$content-type != ''">
                <xsl:attribute name="content-type">
                    <xsl:value-of select="concat('content-type:',$content-type)"/>
                </xsl:attribute>
            </xsl:if>

            <xsl:if test="$bgcolor != ''">
                <xsl:attribute name="background-color">
                    <xsl:value-of select="$bgcolor"/>
                </xsl:attribute>
            </xsl:if>

            <xsl:if test="@align">
                <xsl:attribute name="text-align">
                    <xsl:value-of select="@align"/>
                </xsl:attribute>
            </xsl:if>

            <xsl:if test="@valign">
                <xsl:attribute name="display-align">
                    <xsl:choose>
                        <xsl:when test="@valign = 'top'">before</xsl:when>
                        <xsl:when test="@valign = 'middle'">center</xsl:when>
                        <xsl:when test="@valign = 'bottom'">after</xsl:when>
                        <xsl:otherwise>auto</xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
            </xsl:if>
        </fo:external-graphic>
    </xsl:template>


    <!--
        ###########################################################################################
        List support
        ###########################################################################################
    -->
    <!-- Format Variable Lists as Blocks (prevents horizontal overflow). -->
    <xsl:param name="variablelist.as.blocks">1</xsl:param>
    <xsl:attribute-set name="variablelist.term.properties">
      <xsl:attribute name="font-weight">bold</xsl:attribute> 
    </xsl:attribute-set>

    <!-- The horrible list spacing problems, this is much better. -->
    <xsl:attribute-set name="list.block.spacing">
        <xsl:attribute name="space-before.optimum">2em</xsl:attribute>
        <xsl:attribute name="space-before.minimum">1em</xsl:attribute>
        <xsl:attribute name="space-before.maximum">3em</xsl:attribute>
        <xsl:attribute name="space-after.optimum">0.1em</xsl:attribute>
        <xsl:attribute name="space-after.minimum">0.1em</xsl:attribute>
        <xsl:attribute name="space-after.maximum">0.1em</xsl:attribute>
    </xsl:attribute-set>


    <!--
        ###########################################################################################
        Table support
        ###########################################################################################
    -->
    <xsl:attribute-set name="table.cell.padding">
        <xsl:attribute name="padding-left">4pt</xsl:attribute>
        <xsl:attribute name="padding-right">4pt</xsl:attribute>
        <xsl:attribute name="padding-top">2pt</xsl:attribute>
        <xsl:attribute name="padding-bottom">2pt</xsl:attribute>
    </xsl:attribute-set>

    <!-- Only hairlines as frame and cell borders in tables -->
    <xsl:param name="table.frame.border.thickness">0.3pt</xsl:param>
    <xsl:param name="table.cell.border.thickness">0.15pt</xsl:param>
    <xsl:param name="table.cell.border.color">#5c5c4f</xsl:param>
    <xsl:param name="table.frame.border.color">#5c5c4f</xsl:param>
    <xsl:param name="table.cell.border.right.color">white</xsl:param>
    <xsl:param name="table.cell.border.left.color">white</xsl:param>
    <xsl:param name="table.frame.border.right.color">white</xsl:param>
    <xsl:param name="table.frame.border.left.color">white</xsl:param>

    <!-- Some padding inside tables -->
    <xsl:attribute-set name="table.cell.padding">
        <xsl:attribute name="padding-left">4pt</xsl:attribute>
        <xsl:attribute name="padding-right">4pt</xsl:attribute>
        <xsl:attribute name="padding-top">2pt</xsl:attribute>
        <xsl:attribute name="padding-bottom">2pt</xsl:attribute>
    </xsl:attribute-set>


    <!--
        ###########################################################################################
        Q-and-A support
        ###########################################################################################
    -->
    <xsl:param name="qandadiv.autolabel" select="0"/>


    <!--
        ###########################################################################################
        <programlisting/> highlighting using jHighLight

        NOTE : This stuff needs to go away ASAP!
        ###########################################################################################
    -->
    <xsl:template match="programlisting">

        <xsl:variable name="language">
            <xsl:value-of select="s:toUpperCase(string(@language))" xmlns:s="java:java.lang.String"/>
        </xsl:variable>

        <xsl:variable name="hilighter" select="jbh:new()"/>
        <xsl:variable name="parsable" select="jbh:isParsable($language)"/>

        <fo:block xsl:use-attribute-sets="monospace.verbatim.properties shade.verbatim.style">
        <!--
        <fo:block background-color="#FFF"
                  border-top-style="dotted"
                  border-bottom-style="dotted"
                  border-width=".3mm"
                  border-color="#BFBFBF"
                  font-family="{$programlisting.font}"
                  font-size="{$programlisting.font.size}"
                  space-before="12pt"
                  space-after="12pt"
                  linefeed-treatment="preserve"
                  white-space-collapse="false"
                  white-space-treatment="preserve"
                  padding-bottom="12pt"
                  padding-top="12pt"
                  padding-right="12pt"
                  padding-left="12pt">
         -->

            <xsl:choose>
                <xsl:when test="$parsable = 'true'">
                    <xsl:for-each select="node()">
                        <xsl:choose>
                            <xsl:when test="self::text()">
                                <xsl:variable name="child.content" select="."/>

                                <xsl:variable name="caller"
                                              select="jbh:parseText($hilighter, $language, string($child.content), 'UTF-8')"/>
                                <xsl:variable name="noOfTokens" select="jbh:getNoOfTokens($caller)"/>

                                <xsl:call-template name="iterator">
                                    <xsl:with-param name="caller" select="$caller"/>
                                    <xsl:with-param name="noOfTokens" select="$noOfTokens"/>
                                </xsl:call-template>
                            </xsl:when>
                            <xsl:otherwise>
                                <fo:inline>
                                    <xsl:call-template name="anchor"/>
                                    <xsl:apply-templates select="." mode="callout-bug"/>
                                </fo:inline>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>

        </fo:block>
    </xsl:template>


    <xsl:template name="iterator">
        <xsl:param name="caller"/>
        <xsl:param name="noOfTokens"/>
        <xsl:param name="i" select="0"/>

        <xsl:variable name="style" select="jbh:getStyle($caller, $i)"/>
        <xsl:variable name="token" select="jbh:getToken($caller, $i)"/>

        <xsl:choose>
            <xsl:when test="$style = 'java_keyword'">
                <fo:inline color="#7F1B55" font-weight="bold">
                    <xsl:value-of select="$token"/>
                </fo:inline>
            </xsl:when>
            <xsl:when test="$style = 'java_plain'">
                <fo:inline color="#000000">
                    <xsl:value-of select="$token"/>
                </fo:inline>
            </xsl:when>
            <xsl:when test="$style = 'java_type'">
                <fo:inline color="#000000">
                    <xsl:value-of select="$token"/>
                </fo:inline>
            </xsl:when>
            <xsl:when test="$style = 'java_separator'">
                <fo:inline color="#000000">
                    <xsl:value-of select="$token"/>
                </fo:inline>
            </xsl:when>
            <xsl:when test="$style = 'java_literal'">
                <fo:inline color="#2A00FF">
                    <xsl:value-of select="$token"/>
                </fo:inline>
            </xsl:when>
            <xsl:when test="$style = 'java_comment'">
                <fo:inline color="#3F7F5F">
                    <xsl:value-of select="$token"/>
                </fo:inline>
            </xsl:when>
            <xsl:when test="$style = 'java_javadoc_comment'">
                <fo:inline color="#3F5FBF" font-style="italic">
                    <xsl:value-of select="$token"/>
                </fo:inline>
            </xsl:when>
            <xsl:when test="$style = 'java_operator'">
                <fo:inline color="#000000">
                    <xsl:value-of select="$token"/>
                </fo:inline>
            </xsl:when>
            <xsl:when test="$style = 'java_javadoc_tag'">
                <fo:inline color="#7F9FBF" font-weight="bold" font-style="italic">
                    <xsl:value-of select="$token"/>
                </fo:inline>
            </xsl:when>
            <xsl:when test="$style = 'xml_plain'">
                <fo:inline color="#000000">
                    <xsl:value-of select="$token"/>
                </fo:inline>
            </xsl:when>
            <xsl:when test="$style = 'xml_char_data'">
                <fo:inline color="#000000">
                    <xsl:value-of select="$token"/>
                </fo:inline>
            </xsl:when>
            <xsl:when test="$style = 'xml_tag_symbols'">
                <fo:inline color="#008080">
                    <xsl:value-of select="$token"/>
                </fo:inline>
            </xsl:when>
            <xsl:when test="$style = 'xml_comment'">
                <fo:inline color="#3F5FBF">
                    <xsl:value-of select="$token"/>
                </fo:inline>
            </xsl:when>
            <xsl:when test="$style = 'xml_attribute_value'">
                <fo:inline color="#2A00FF">
                    <xsl:value-of select="$token"/>
                </fo:inline>
            </xsl:when>
            <xsl:when test="$style = 'xml_attribute_name'">
                <fo:inline color="#7F007F" font-weight="bold">
                    <xsl:value-of select="$token"/>
                </fo:inline>
            </xsl:when>
            <xsl:when test="$style = 'xml_processing_instruction'">
                <fo:inline color="#000000" font-weight="bold" font-style="italic">
                    <xsl:value-of select="$token"/>
                </fo:inline>
            </xsl:when>
            <xsl:when test="$style = 'xml_tag_name'">
                <fo:inline color="#3F7F7F">
                    <xsl:value-of select="$token"/>
                </fo:inline>
            </xsl:when>
            <xsl:when test="$style = 'xml_rife_tag'">
                <fo:inline color="#000000">
                    <xsl:value-of select="$token"/>
                </fo:inline>
            </xsl:when>
            <xsl:when test="$style = 'xml_rife_name'">
                <fo:inline color="#008CCA">
                    <xsl:value-of select="$token"/>
                </fo:inline>
            </xsl:when>
            <xsl:otherwise>
                <fo:inline color="black">
                    <xsl:value-of select="$token"/>
                </fo:inline>
            </xsl:otherwise>
        </xsl:choose>

        <xsl:if test="$i &lt; $noOfTokens - 1">
            <xsl:call-template name="iterator">
                <xsl:with-param name="caller" select="$caller"/>
                <xsl:with-param name="noOfTokens" select="$noOfTokens"/>
                <xsl:with-param name="i" select="$i + 1"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>

    <xsl:attribute-set name="monospace.verbatim.properties"
                       use-attribute-sets="verbatim.properties monospace.properties">
        <xsl:attribute name="font-size">9pt</xsl:attribute>
        <xsl:attribute name="text-align">start</xsl:attribute>
        <xsl:attribute name="wrap-option">wrap</xsl:attribute>
        <xsl:attribute name="hyphenation-character">&#x25BA;</xsl:attribute>
    </xsl:attribute-set>

    <xsl:param name="shade.verbatim" select="1"/>
    <xsl:attribute-set name="shade.verbatim.style">
        <xsl:attribute name="wrap-option">wrap</xsl:attribute>
        <xsl:attribute name="background-color">
            <xsl:choose>
                <xsl:when test="ancestor::d:note">
                    <xsl:text>#D6DEE0</xsl:text>
                </xsl:when>
                <xsl:when test="ancestor::d:caution">
                    <xsl:text>#FAF8ED</xsl:text>
                </xsl:when>
                <xsl:when test="ancestor::d:important">
                    <xsl:text>#E1EEF4</xsl:text>
                </xsl:when>
                <xsl:when test="ancestor::d:warning">
                    <xsl:text>#FAF8ED</xsl:text>
                </xsl:when>
                <xsl:when test="ancestor::d:tip">
                    <xsl:text>#D5E1D5</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>#FFF</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="color">
            <xsl:choose>
                <xsl:when test="ancestor::d:note">
                    <xsl:text>#334558</xsl:text>
                </xsl:when>
                <xsl:when test="ancestor::d:caution">
                    <xsl:text>#334558</xsl:text>
                </xsl:when>
                <xsl:when test="ancestor::d:important">
                    <xsl:text>#334558</xsl:text>
                </xsl:when>
                <xsl:when test="ancestor::d:warning">
                    <xsl:text>#334558</xsl:text>
                </xsl:when>
                <xsl:when test="ancestor::d:tip">
                    <xsl:text>#334558</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>#333</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="padding-left">12pt</xsl:attribute>
        <xsl:attribute name="padding-right">12pt</xsl:attribute>
        <xsl:attribute name="padding-top">6pt</xsl:attribute>
        <xsl:attribute name="padding-bottom">6pt</xsl:attribute>
        <xsl:attribute name="margin-left">
            <xsl:value-of select="$title.margin.left"/>
        </xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="verbatim.properties">
        <xsl:attribute name="border-top-style">dotted</xsl:attribute>
        <xsl:attribute name="border-bottom-style">dotted</xsl:attribute>
        <xsl:attribute name="border-width">.3mm</xsl:attribute>
        <xsl:attribute name="border-color">#BFBFBF</xsl:attribute>
        <xsl:attribute name="space-before.minimum">0.8em</xsl:attribute>
        <xsl:attribute name="space-before.optimum">1em</xsl:attribute>
        <xsl:attribute name="space-before.maximum">1.2em</xsl:attribute>
        <xsl:attribute name="space-after.minimum">0.8em</xsl:attribute>
        <xsl:attribute name="space-after.optimum">1em</xsl:attribute>
        <xsl:attribute name="space-after.maximum">1.2em</xsl:attribute>
        <xsl:attribute name="hyphenate">false</xsl:attribute>
        <xsl:attribute name="wrap-option">wrap</xsl:attribute>
        <xsl:attribute name="white-space-collapse">false</xsl:attribute>
        <xsl:attribute name="white-space-treatment">preserve</xsl:attribute>
        <xsl:attribute name="linefeed-treatment">preserve</xsl:attribute>
        <xsl:attribute name="text-align">start</xsl:attribute>
    </xsl:attribute-set>

  <xsl:template match="formalpara/title|formalpara/info/title">
    <xsl:variable name="titleStr">
        <xsl:apply-templates/>
    </xsl:variable>
    <xsl:variable name="lastChar">
      <xsl:if test="$titleStr != ''">
        <xsl:value-of select="substring($titleStr,string-length($titleStr),1)"/>
      </xsl:if>
    </xsl:variable>
  
    <fo:inline font-weight="bold"
               keep-with-next.within-line="always"
               padding-end="1em">
      <xsl:choose>
        <xsl:when test="not(ancestor::d:note) and not(ancestor::d:warning) and not(ancestor::d:tip) and not(ancestor::d:important) and not(ancestor::d:caution)">
          <xsl:attribute name="color">#8F2C1D</xsl:attribute>
        </xsl:when>
      </xsl:choose>
  
      <xsl:copy-of select="$titleStr"/>
      <xsl:if test="$lastChar != ''
                    and not(contains($runinhead.title.end.punct, $lastChar))">
        <xsl:value-of select="$runinhead.default.title.end.punct"/>
      </xsl:if>
      <xsl:text>&#160;</xsl:text>
    </fo:inline>
  </xsl:template>

  <!-- Line break -->
  <xsl:template match="processing-instruction('asciidoc-br')">
    <fo:block/>
  </xsl:template>

  <!-- Horizontal ruler -->
  <xsl:template match="processing-instruction('asciidoc-hr')">
    <fo:block space-after="1em">
      <fo:leader leader-pattern="rule" rule-thickness="0.5pt" rule-style="solid" leader-length.minimum="100%"/>
    </fo:block>
  </xsl:template>

  <!-- Page break -->
  <xsl:template match="processing-instruction('asciidoc-pagebreak')">
     <fo:block break-after="page"/>
  </xsl:template>

  <xsl:template match="title" mode="book.titlepage.recto.auto.mode">
    <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="book.titlepage.recto.style" text-align="center" font-size="24.8832pt" space-before="18.6624pt">
      <xsl:call-template name="division.title">
        <xsl:with-param name="node" select="ancestor-or-self::book[1]"/>
      </xsl:call-template>
    </fo:block>
  </xsl:template>

  <xsl:template match="revision" mode="book.titlepage.recto.auto.mode">
    <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="book.titlepage.recto.style" text-align="center" font-size="14.4pt" space-before="1in" font-family="{$title.fontset}">
      <xsl:call-template name="gentext">
        <xsl:with-param name="key" select="'Revision'"/>
      </xsl:call-template> 
      <xsl:call-template name="gentext.space"/>
      <xsl:apply-templates select="revnumber" mode="titlepage.mode"/>
    </fo:block>
    <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="book.titlepage.recto.style" text-align="center" font-size="14.4pt" font-family="{$title.fontset}">
      <xsl:apply-templates select="date" mode="titlepage.mode"/> 
    </fo:block>
  </xsl:template>

  <xsl:template name="book.titlepage.recto">
    <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="bookinfo/title"/>
    <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="bookinfo/author"/>
    <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="bookinfo/revhistory/revision[1]"/>
    <!--
    <xsl:apply-templates mode="titlepage.mode" select="bookinfo/revhistory"/>
    -->
  </xsl:template>

  <xsl:template name="book.titlepage.before.verso"/>
  <xsl:template name="book.titlepage.verso"/>

  <xsl:template name="preface.titlepage.recto">
    <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="preface.titlepage.recto.style">
      <xsl:call-template name="component.title">
        <xsl:with-param name="node" select="ancestor-or-self::preface[1]"/>
      </xsl:call-template>
    </fo:block>
  </xsl:template>

  <xsl:template match="title" mode="chapter.titlepage.recto.auto.mode">
    <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="chapter.titlepage.recto.style">
      <xsl:call-template name="component.title">
        <xsl:with-param name="node" select="ancestor-or-self::chapter[1]"/>
      </xsl:call-template>
    </fo:block>
  </xsl:template>

  <xsl:template match="example" mode="object.title.template">
    <xsl:choose>
      <xsl:when test="local-name(parent::*) = 'example'">
        <xsl:text>Example</xsl:text>
        <!--
        <xsl:call-template name="gentext.template">
          <xsl:with-param name="context" select="'title'"/>
          <xsl:with-param name="name" select="'example'"/>
        </xsl:call-template>
        -->
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="gentext.template">
          <xsl:with-param name="context" select="'title'"/>
          <xsl:with-param name="name" select="'result'"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:param name="local.l10n.xml" select="document('')" />
  <l:i18n xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0">
    <l:l10n language="en">
      <l:context name="title">
        <l:template name="result" text="Result"/>
      </l:context>
    </l:l10n>
  </l:i18n>

</xsl:stylesheet>
