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

$namespaces:
  s: https://schema.org/

s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0002-5574-2787
    s:email: eva.sciacca@inaf.it
    s:name: Eva Sciacca
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9290-2017
    s:email: iacopo.colonnelli@unito.it
    s:name: Iacopo Colonnelli
  - class: s:Person
    s:identifier: https://orcid.org/0000-0003-1119-4237
    s:email: valentina.cesare@inaf.it
    s:name: Valentina Cesare

s:license: https://spdx.org/licenses/Apache-2.0
