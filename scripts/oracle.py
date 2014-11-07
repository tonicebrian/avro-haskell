#!/usr/bin/env python

import avro.schema
import sys
import os
from os import walk

from avro.datafile import DataFileReader, DataFileWriter
from avro.io import DatumReader, DatumWriter

dataDir = os.path.dirname(os.path.realpath(__file__))+"/../resources"

schemasAndFiles = {
                    "jsonString.schema":["test1.json"],
                    "user.schema":["userTest.json"]
                  }


inputFolder = dataDir+"/in"
for schemaFile,files in schemasAndFiles.iteritems():
    schema = avro.schema.parse(open(dataDir+"/schemas/"+schemaFile).read())
    for fd in files:
        base = os.path.splitext(fd)[0]
        writer = DataFileWriter(open(dataDir+"/out/"+base+".avro","w"), DatumWriter(), schema)
        with open(inputFolder+"/"+fd,'r') as fd:
            lines = fd.readlines()
            for line in lines:
                writer.append(eval(line))
    writer.close()
