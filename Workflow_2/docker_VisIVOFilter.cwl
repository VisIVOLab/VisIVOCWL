#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: VisIVOFilter
requirements:
  DockerRequirement:
    dockerPull: visivolab/visivoserver:latest
  InitialWorkDirRequirement:
    listing:
      - $(inputs.srcFilter0)
      - $(inputs.srcFilter1)
      - $(inputs.srcFilter2)
inputs:
  srcFilter0:
    type: File
  srcFilter1:
    type: File
  srcFilter2:
    type: File
arguments:
  - position: 1
    valueFrom: $(inputs.srcFilter0.basename)
outputs:
  outFilter0:
    type: File
    outputBinding:
      glob: NewTableHALO.bin
  outFilter1:
    type: File
    outputBinding:
      glob: NewTableHALO.bin.head
