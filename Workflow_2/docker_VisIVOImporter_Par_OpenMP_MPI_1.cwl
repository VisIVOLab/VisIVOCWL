#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: mpirun
requirements:
  DockerRequirement:
    dockerPull: visivolab/visivoserver:latest
  InitialWorkDirRequirement:
    listing:
      - $(inputs.srcImp1)
  EnvVarRequirement:
    envDef:
      OMP_NUM_THREADS: $(inputs.message)

arguments:
  - "--allow-run-as-root"
  - valueFrom: "VisIVOImporter"
    position: 2

inputs:
  message: int
  srcImpnp:
    type: int
    inputBinding:
      position: 1
      prefix: --np
  srcImp0:
    type: File
    inputBinding:
      position: 3
  srcImp1:
    type: Directory
outputs:
  outImp0:
    type: File
    outputBinding:
      glob: NewTableHALO.bin
  outImp1:
    type: File
    outputBinding:
      glob: NewTableHALO.bin.head
  outImp2:
    type: File
    outputBinding:
      glob: NewTableGAS.bin
  outImp3:
    type: File
    outputBinding:
      glob: NewTableGAS.bin.head
