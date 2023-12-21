cwlVersion: v1.0
class: Workflow

inputs:
  messageW: int
  srcImpnpW: int
  srcImpW0: File
  srcImpW1: Directory
  srcFilterW0: File
  srcViewW0: File

outputs:
  outViewW:
    type: File[]
    outputSource: viewer/outView

steps:
  importer:
    run: docker_VisIVOImporter_Par_OpenMP_MPI_1.cwl
    in:
      message: messageW
      srcImpnp: srcImpnpW
      srcImp0: srcImpW0
      srcImp1: srcImpW1
    out: [outImp0, outImp1, outImp2, outImp3]
  filter:
    run: docker_VisIVOFilter.cwl
    in:
      srcFilter0: srcFilterW0
      srcFilter1: importer/outImp0
      srcFilter2: importer/outImp1
    out: [outFilter0, outFilter1]
  viewer:
    run: docker_VisIVOViewer_GADGET.cwl 
    in:
      srcView0: srcViewW0
      srcView1: filter/outFilter0
      srcView2: filter/outFilter1
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
