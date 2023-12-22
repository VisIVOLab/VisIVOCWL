# VisIVOCWL
Workflows of VisIVO Server in Common Workflow Language (CWL)

To run the following workflows, the following version of cwl-runner is adopted:
cwl-runner --version
StreamFlow version 0.2.0.dev4

------------------------
Workflow n. 1: Generate four .png images by running in sequence a VisIVO importer and a VisIVO viewer instances.
------------------------
The workflow "docker_VisIVO_ImpView_Workflow.cwl" can be executed with the command:

cwl-runner --streamflow-file streamflow.yml docker_VisIVO_ImpView_Workflow.cwl docker-job_VisIVO_ImpView_Workflow.yml


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



------------------------
Workflow n. 2: Generate four .png images by running in sequence a VisIVO importer, a VisIVO filter and a VisIVO viewer instances, taking as input GADGET data and running the importer in parallel with MPI + OpenMP.
------------------------
The workflow "docker_VisIVO_ImpFilterView_Workflow_GADGET.cwl" can be executed with the command:

cwl-runner docker_VisIVO_ImpFilterView_Workflow_GADGET.cwl docker-job_VisIVO_ImpFilterView_Workflow_GADGET.yml

contained in the cwl-runner_launch_command_VisIVO_ImpFilterView_Workflow_GADGET.txt file.

This workflow executes, in sequence, a command "VisIVOImporter", a command "VisIVOFilter", and a command "VisIVOViewer" of this kind:
1) export OMP_NUM_THREADS=AA
2) mpirun --np BB --allow-run-as-root VisIVOImporter --fformat gadget --out NewTable --file snapdir/snap_091.0
3) VisIVOFilter --op pointproperty --resolution X_RES Y_RES Z_RES --points POS_X POS_Y POS_Z --append --outcol density --file NewTableHALO.bin
4) VisIVOViewer --x POS_X --y POS_Y --z POS_Z --color --colorscalar density --colortable volren_glow --logscale --out VisIVOServerImage NewTableHALO.bin
In the current implementation, the workflow is executed for OMP_NUM_THREADS=2 and mpirun --np 4 (for the importer) and --resolution 64 64 64 (for the filter).

Specifically, the three commands that are executed by the workflow are:
1) export OMP_NUM_THREADS=2 && mpirun --np 4 --allow-run-as-root VisIVOImporter paramFile_Imp_Par_MPI.txt
2) VisIVOFilter paramFile_Filter.txt 
3) VisIVOViewer paramFile_View_GADGET.txt
where each "paramFile" contains the above command specifications.

To make this workflow work, in the directory of the workflow "docker_VisIVO_ImpFilterView_Workflow_GADGET.cwl" the other following files and directories have to be present:
1) paramFile_Imp_Par_MPI.txt (file, needed as input for the VisIVOImporter command)
2) snapdir (directory, needed as input for the VisIVOImporter command)
3) paramFile_Filter.txt (file, needed as input for the VisIVOFilter command)
4) paramFile_View_GADGET.txt (file, needed as input for the VisIVOViewer command)

These are the inputs of the workflow, as described in the "docker-job_VisIVO_ImpFilterView_Workflow_GADGET.yml" file.
The first command of the workflow, "VisIVOImporter ...", generates the "NewTableHALO.bin", "NewTableHALO.bin.head", "NewTableGAS.bin", "NewTableGAS.bin.head", in four different directories. The second command of the workflow, "VisIVOFilter ...", modifies a couple of these files (either "NewTableHALO.bin" and "NewTableHALO.bin.head" or "NewTableGAS.bin" and "NewTableGAS.bin.head"). The workflow (the last step of the workflow, given by the "VisIVOViewer ..." command) generates as output four .png images, "VisIVOServerImage0.png", "VisIVOServerImage1.png", "VisIVOServerImage2.png", and "VisIVOServerImage3.png", that are saved in four different directories. All the subproducts of the workflow do not exist anymore at the end of the workflow execution.
