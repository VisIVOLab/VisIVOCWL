cwlVersion: v1.0
class: Workflow

inputs:
  srcImpW0: File
  srcImpW1: File
  srcViewW0: File

outputs:
  outViewW:
    type: File[]
    outputSource: viewer/outView

steps:
  importer:
    run: docker_VisIVOImporter.cwl
    in:
      srcImp0: srcImpW0
      srcImp1: srcImpW1
    out: [outImp0, outImp1]
  viewer:
    run: docker_VisIVOViewer.cwl 
    in:
      srcView0: srcViewW0
      srcView1: importer/outImp0
      srcView2: importer/outImp1
    out: [outView]
