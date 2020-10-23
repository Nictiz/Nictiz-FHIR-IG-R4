# Nictiz-FHIR-IG-R4

Experimental repository to test conformance resources/examples with the IG Publisher.

## Purpose
Quality assurance testing of conformance resources in a branch of Nictiz R4 repository's.

## Software list
* Jekyll (https://jekyllrb.com/docs/installation )
* JRE (https://www.oracle.com/java/technologies/javase-jre8-downloads.html)

## How to run
* Clone this repo next to wherever you have cloned the R4 repository. If you want to create separate IG's for each repo/project, rename the resulting folder to align with the target repo (for example, 'Nictiz-FHIR-IG-Zib2020 when targeting the 'Zib2017' repo). This is really only needed to make HTML links across packages work, otherwise you can just reuse this repo for different projects.
* Run `_updatePublisher.sh` or `_updatePublisher.bat`. Do **NOT** choose overwrite scripts when prompted unless you have a good reason. This adds the IG Publisher to input-cache. Because of the size of ~130MB it is in .gitignore
* Run `_updateSources*.sh` or `_updateSources*.bat`. This will get examples and conformance resources from whatever branch you have active in the corresponding repo folder. Please see the note about package versions below. 
* Run `_genonce.sh` or `_genonce.bat` to run the build.

The short version. On *nix/macOS use 
```
./_updateSources*.sh | tee _updateSources.log; ./_genonce*.sh | tee _genonce.log
```

on Windows use

```
_updateSources.bat 1> _updateSources.log 2>&1
type _updateSources.log
_genonce.bat 1> _genonce.log 2>&1
type _genonce.log
```

## Package versions

When running, the IG Publisher will create a FHIR package from the repository and install it to the local package cache, where other FHIR applications can find it. This can be used for local testing. To facilitate this, all the package versions in this repo are set by default to 'dev', and likewise all dependencies on Nictiz packages have been made on version 'dev'. Dependency's can thus be resolved to the local package cache if the IG Publisher has been run for that repo.

If one of these versions should be overridden, it can be done so in the corresponding XSL files for the different repo's (they act as a template for the ImplementationGuide resource). Please don't check in these changes to git.

## Background
This repository is based on the project [HL7 FHIR sample-ig](https://github.com/FHIR/sample-ig). FHIR is © and ® HL7. See the HL7 FHIR [license](http://hl7.org/fhir/license.html) for more details.

See IG Publisher documentation for specifics on how that works and what the system requirements are: [https://confluence.hl7.org/display/FHIR/IG+Publisher+Documentation](https://confluence.hl7.org/display/FHIR/IG+Publisher+Documentation).
