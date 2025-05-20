#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: VisIVOFilter
requirements:
  DockerRequirement:
    dockerPull: visivolab/visivoserver:latest
  InitialWorkDirRequirement:
    listing:
      - $(inputs.srcFilterF20)
      - $(inputs.srcFilterF21)
      - $(inputs.srcFilterF22)
stdout: output.txt
inputs:
  srcFilterF20:
    type: File
  srcFilterF21:
    type: File
  srcFilterF22:
    type: File
arguments:
  - position: 1
    valueFrom: $(inputs.srcFilterF20.basename)
outputs:
  outFilterF20:
    type: File
    outputBinding:
      glob: results.txt
  outFilterF21:
    type: stdout
