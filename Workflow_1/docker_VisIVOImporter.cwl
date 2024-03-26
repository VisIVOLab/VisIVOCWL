#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: VisIVOImporter
requirements:
  DockerRequirement:
    dockerPull: neaniasspace/visivoserver:latest
  InitialWorkDirRequirement:
    listing:
      - $(inputs.srcImp1)
inputs:
  srcImp0:
    type: File
    inputBinding:
      position: 1
  srcImp1:
    type: File
outputs:
  outImp0:
    type: File
    outputBinding:
      glob: VisIVOServerBinary.bin
  outImp1:
    type: File
    outputBinding:
      glob: VisIVOServerBinary.bin.head
