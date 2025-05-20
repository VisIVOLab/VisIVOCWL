#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: VisIVOFilter
requirements:
  DockerRequirement:
    dockerPull: visivolab/visivoserver:latest
  InitialWorkDirRequirement:
    listing:
      - $(inputs.srcFilterF0)
      - $(inputs.srcFilterF1)
      - $(inputs.srcFilterF2)
inputs:
  srcFilterF0:
    type: File
  srcFilterF1:
    type: File
  srcFilterF2:
    type: File
arguments:
  - position: 1
    valueFrom: $(inputs.srcFilterF0.basename)
outputs:
  outFilterF0:
    type: File
    outputBinding:
      glob: NewTableHALORand.bin
  outFilterF1:
    type: File
    outputBinding:
      glob: NewTableHALORand.bin.head
