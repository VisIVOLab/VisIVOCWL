cwlVersion: v1.0
class: Workflow

inputs:
  messageW: int
  srcImpnpW: int
  srcImpW0: File
  srcImpW1: Directory
  srcFilterF1W0: File
  srcFilterF2W0: File
  srcFilterF2W1: File
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
  filter1:
    run: docker_VisIVOFilter_F1.cwl
    in:
      srcFilterF10: srcFilterF1W0
      srcFilterF11: importer/outImp0
      srcFilterF12: importer/outImp1
    out: [outFilterF10, outFilterF11]
  filter2:
    run: docker_VisIVOFilter_F2.cwl
    in:
      srcFilterF20: srcFilterF2W0
      srcFilterF21: srcFilterF2W1
      srcFilterF22: filter1/outFilterF10
      srcFilterF23: filter1/outFilterF11
      srcFilterF24: importer/outImp0
      srcFilterF25: importer/outImp1
    out: [outFilterF20, outFilterF21]
  viewer:
    run: docker_VisIVOViewer_GADGET_Post_F2.cwl 
    in:
      srcView0: srcViewW0
      srcView1: filter2/outFilterF20
      srcView2: filter2/outFilterF21
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
