@ECHO OFF
SET publisher_jar=publisher.jar
SET input_cache_path=./input-cache/

REM 2020-01-01 Nictiz additions
REM ECHO Deleting .DS_Store files
REM for /R . %%F in (.DS_Store) do del /F /Q %%F

SET nictiz_input_source=../Nictiz-R4-Zib2020
SET nictiz_input_examples_beschikbaarstellen=../HL7-mappings/ada_2_fhir-r4/lab/3.0.0/beschikbaarstellen_laboratoriumresultaten/fhir_instance
SET nictiz_input_examples_sturen=../HL7-mappings/ada_2_fhir-r4/lab/3.0.0/sturen_laboratoriumresultaten/fhir_instance
IF EXIST %nictiz_input_source% (
    ECHO Refreshing source from:
    git -C %nictiz_input_source% status
    ECHO.
    
    ECHO Refresh examples from checked out Git branch
    IF EXIST input\examples (
        del /Q /S input\examples\*
    ) ELSE (
        mkdir input\examples
    )
    for /R %nictiz_input_examples_beschikbaarstellen% %%F in (*.xml) do copy "%%F" input\examples\
    for /R %nictiz_input_examples_sturen% %%F in (*.xml) do copy "%%F" input\examples\
    
    ECHO Refresh conformance resources from checked out Git branch
    IF EXIST input\resources (
        del /Q /S input\resources\*
    ) ELSE (
        mkdir input\resources
    )
    for /R "%nictiz_input_source%\resources" %%F in (*.xml) do copy "%%F" input\resources\

    IF EXIST ..\zib-O2Saturation.xml (
       del /Q /S input\resources\zib-O2Saturation.xml
       copy ..\zib-O2Saturation.xml input\resources\
    ) ELSE ()
    
    java -cp %input_cache_path%/%publisher_jar% net.sf.saxon.Transform -xsl:Zib2020.xsl -s:Zib2020.xsl -o:input/myig.xml
) ELSE (
    ECHO Cannot refresh conformance resources. Nictiz IG Publisher is not next to %nictiz_input_source%
)

REM 2020-01-01 Nictiz additions
