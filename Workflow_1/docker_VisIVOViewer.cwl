#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: VisIVOViewer
requirements:
  DockerRequirement:
    dockerPull: neaniasspace/visivoserver:latest
  InitialWorkDirRequirement:
    listing:
      - $(inputs.srcView0)
      - $(inputs.srcView1)
      - $(inputs.srcView2)
inputs:
  srcView0:
    type: File
  srcView1:
    type: File
  srcView2:
    type: File
arguments:
  - position: 1 
    valueFrom: $(inputs.srcView0.basename) 
outputs:
  outView:
    type: File[]
    outputBinding:
      glob: VisIVOServerImage*.png
