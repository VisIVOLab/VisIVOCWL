#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: VisIVOFilter
requirements:
  DockerRequirement:
    dockerPull: visivolab/visivoserver:latest
  InitialWorkDirRequirement:
    listing:
      - $(inputs.srcFilterF10)
      - $(inputs.srcFilterF11)
      - $(inputs.srcFilterF12)
inputs:
  srcFilterF10:
    type: File
  srcFilterF11:
    type: File
  srcFilterF12:
    type: File
arguments:
  - position: 1
    valueFrom: $(inputs.srcFilterF10.basename)
outputs:
  outFilterF10:
    type: File
    outputBinding:
      glob: densityvolume.bin
  outFilterF11:
    type: File
    outputBinding:
      glob: densityvolume.bin.head
