#!/bin/bash
publisher_jar=publisher.jar
input_cache_path=./input-cache/

#### 2020-01-01 Nictiz additions ####
echo Deleting .DS_Store files
find . -name ".DS_Store" -exec rm {} \;

nictiz_input_source=../Nictiz-R4-eAfspraak
if [ -e $nictiz_input_source ]; then
    if [ ! -d input ];
        then mkdir input
    fi
    if [ ! -d input/resources ];
        then mkdir input/resources
    fi
    if [ ! -d input/examples ];
        then mkdir input/examples
    fi
    
    echo Refreshing source from:
    git -C $nictiz_input_source status
    echo ""
    
    echo Refresh examples from checked out Git branch
    rm -rf input/examples/*
    find $nictiz_input_source/Examples -name "*.xml" -exec cp {} input/examples/ \;
    
    echo Refresh conformance resources from checked out Git branch
    rm -rf input/resources/*
    find $nictiz_input_source/Profiles -name "*.xml" -exec cp {} input/resources/ \;
    
    echo Creating IG from input
    if [ -e input/myig.xml ]; then 
        mv input/myig.xml input/myig-old.xml
    fi
    
    java -cp $input_cache_path/$publisher_jar net.sf.saxon.Transform -xsl:eAfspraak.xsl -s:eAfspraak.xsl -o:input/myig.xml
else
    echo Cannot refresh conformance resources. Nictiz IG Publisher is not next to $nictiz_input_source
fi

#### 2020-01-01 Nictiz additions ####