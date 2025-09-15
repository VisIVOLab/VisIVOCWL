#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: VisIVOImporter
requirements:
  DockerRequirement:
    dockerPull: visivolab/visivoserver:latest
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
      glob: VisIVOServerBinaryDARK.bin
  outImp1:
    type: File
    outputBinding:
      glob: VisIVOServerBinaryDARK.bin.head
  outImp2:
    type: File
    outputBinding:
      glob: VisIVOServerBinaryGAS.bin
  outImp3:
    type: File
    outputBinding:
      glob: VisIVOServerBinaryGAS.bin.head
  outImp4:
    type: File
    outputBinding:
      glob: VisIVOServerBinarySTAR.bin
  outImp5:
    type: File
    outputBinding:
      glob: VisIVOServerBinarySTAR.bin.head
