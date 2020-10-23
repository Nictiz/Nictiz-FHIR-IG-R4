@ECHO OFF
SET publisher_jar=publisher.jar
SET input_cache_path=./input-cache/

REM 2020-01-01 Nictiz additions
REM ECHO Deleting .DS_Store files
REM for /R . %%F in (.DS_Store) do del /F /Q %%F

SET nictiz_input_source=../Nictiz-R4-BgZ
IF EXIST %nictiz_input_source% (
    ECHO Refreshing source from:
    git -C %nictiz_input_source% status
    ECHO.
    
    ECHO Refresh conformance resources from checked out Git branch
    del /Q /S input\resources\*
    for /R "%nictiz_input_source%\CapabilityStatements" %%F in (*.xml) do copy "%%F" input\resources\
    
    java -cp %input_cache_path%/%publisher_jar% net.sf.saxon.Transform -xsl:BgZ.xsl -s:BgZ.xsl -o:input/myig.xml
) ELSE (
    ECHO Cannot refresh conformance resources. Nictiz IG Publisher is not next to %nictiz_input_source%
)

REM 2020-01-01 Nictiz additions