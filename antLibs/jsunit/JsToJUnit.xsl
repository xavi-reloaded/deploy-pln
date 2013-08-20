<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:lxslt="http://xml.apache.org/xslt"
    xmlns:redirect="http://xml.apache.org/xalan/redirect"
    xmlns:stringutils="xalan://org.apache.tools.ant.util.StringUtils"
    extension-element-prefixes="redirect">

	<xsl:output method="xml" indent="yes" encoding="UTF-8"/>

	<xsl:template match="browserResult">
		<xsl:variable name="numberOfTests" select="count(descendant::testCase)" />
		<xsl:variable name="numberOfFailures" select="count(descendant::failure)" />
		<xsl:variable name="totalTime" select='format-number(sum(descendant::testCase/@time), "#.###")' />
		<testsuites>
			<testsuite failures="{$numberOfFailures}" errors="0" hostname="" id="" name="JsUnit Tests" package="" tests="{$numberOfTests}" time="{$totalTime}">

				<properties>
					<xsl:for-each select="properties/property">
						<property name="{@name}" value="{@value}" />
					</xsl:for-each>
				</properties>
				<xsl:for-each select="testCases/testCase">
					<testcase classname="{substring-before(@name,substring-after(@name, '.html'))}" name="{substring-after(@name,'.html:')}" time="{@time}">
						<xsl:if test="failure">
							<failure><xsl:value-of select="failure" /></failure>

						</xsl:if>
					</testcase>
				</xsl:for-each>
			</testsuite>
		</testsuites>
	</xsl:template>
</xsl:stylesheet>