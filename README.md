# VisIVOCWL
Workflows of VisIVO Server in Common Workflow Language (CWL)

To run the following workflows, the following version of cwl-runner is adopted:
cwl-runner --version
StreamFlow version 0.2.0.dev4

------------------------
Workflow n. 1: Generate four .png images by running in sequence a VisIVO importer and a VisIVO viewer instances.
------------------------
The workflow "docker_VisIVO_ImpView_Workflow.cwl" can be executed with the command:
cwl-runner docker_VisIVO_ImpView_Workflow.cwl docker-job_VisIVO_ImpView_Workflow.yml

This workflow executes, in sequence, a command "VisIVOImporter" and a command "VisIVOViewer" of this kind:
1) VisIVOImporter --fformat ascii clusterfields4.ascii
2) VisIVOViewer -x X -y Y -z Z --scale --glyphs pixel VisIVOServerBinary.bin

Specifically, the two commands that are executed by the workflow are:
1) VisIVOImporter paramFile_Imp.txt  
2) VisIVOViewer paramFile_View.txt
where each "paramFile" contains the above command specifications.

To make this workflow work, in the directory of the workflow "docker_VisIVO_ImpView_Workflow.cwl" the other following files have to be present:
1) paramFile_Imp.txt
2) clusterfields4.ascii
3) paramFile_View.txt

These are the inputs of the workflow, as described in the "docker-job_VisIVO_ImpView_Workflow.yml" file.
The first command of the workflow, "VisIVOImporter ...", generates the "VisIVOServerBinary.bin" and the "VisIVOServerBinary.bin.head" files, that are taken as input by the second command of the workflow, "VisIVOViewer ...". These two files does not exist anymore at the end of the workflow execution. The workflow generates as output four .png images, "VisIVOServerImage0.png", "VisIVOServerImage1.png", "VisIVOServerImage2.png", and "VisIVOServerImage3.png", that are saved in four different directories.
