#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: VisIVOFilter
requirements:
  DockerRequirement:
    dockerPull: nicolatuccari/visivotest:latest
  InitialWorkDirRequirement:
    listing:
      - $(inputs.srcFilterF20)
      - $(inputs.srcFilterF21)
      - $(inputs.srcFilterF22)
      - $(inputs.srcFilterF23)
      - $(inputs.srcFilterF24)
      - $(inputs.srcFilterF25)
inputs:
  srcFilterF20:
    type: File
  srcFilterF21:
    type: File
  srcFilterF22:
    type: File
  srcFilterF23:
    type: File
  srcFilterF24:
    type: File
  srcFilterF25:
    type: File
arguments:
  - position: 1
    valueFrom: $(inputs.srcFilterF20.basename)
outputs:
  outFilterF20:
    type: File
    outputBinding:
      glob: NewTableHALOMerge.bin
  outFilterF21:
    type: File
    outputBinding:
      glob: NewTableHALOMerge.bin.head
