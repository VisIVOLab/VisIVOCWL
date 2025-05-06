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
4) streamflow.yml

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




------------------------
Workflow n. 3.1 (option "pointproperty" in the first VisIVOFilter command): Generate four .png images by running in sequence a VisIVO importer, two VisIVO filters and a VisIVO viewer instances, taking as input GADGET data and running the importer in parallel with MPI + OpenMP.
------------------------
The workflow "docker_VisIVO_ImpFilterF1F2View_Workflow_GADGET.cwl" can be executed with the command:

cwl-runner docker_VisIVO_ImpFilterF1F2View_Workflow_GADGET.cwl docker-job_VisIVO_ImpFilterF1F2View_Workflow_GADGET.yml

contained in the cwl-runner_launch_command_VisIVO_ImpFilterF1F2View_Workflow_GADGET.txt file.

This workflow executes, in sequence, a command "VisIVOImporter", two commands "VisIVOFilter", and a command "VisIVOViewer" of this kind:
1) export OMP_NUM_THREADS=AA
2) mpirun --np BB --allow-run-as-root VisIVOImporter --fformat gadget --out NewTable --file snapdir/snap_091.0
3) VisIVOFilter --op pointproperty --resolution X_RES Y_RES Z_RES --points POS_X POS_Y POS_Z --out density.bin --outcol density --file NewTableHALO.bin
4) VisIVOFilter --op merge --out NewTableHALOMerge.bin --filelist tabselection.txt
5) VisIVOViewer --x POS_X_tab_1 --y POS_Y_tab_1 --z POS_Z_tab_1 --color --colorscalar density_tab_2 --colortable volren_glow --logscale --out VisIVOServerImage NewTableHALOMerge.bin
In the current implementation, the workflow is executed for OMP_NUM_THREADS=2 and mpirun --np 4 (for the importer) and --resolution 64 64 64 (for the first filter).

Specifically, the commands that are executed by the workflow are:
1) export OMP_NUM_THREADS=2 && mpirun --np 4 --allow-run-as-root VisIVOImporter paramFile_Imp_Par_MPI.txt
2) VisIVOFilter paramFile_Filter_F1.txt 
3) VisIVOFilter paramFile_Filter_F2.txt  
4) VisIVOViewer paramFile_View_GADGET_Post_F2.txt
where each "paramFile" contains the above command specifications.

The steps of the workflow can be executed separately with the commands:
1) cwl-runner docker_VisIVOImporter_Par_OpenMP_MPI_1.cwl docker-job_VisIVOImporter_Par_OpenMP_MPI.yml
2) cp Output_SubDirectory_Importer_1/NewTableHALO.bin.head .
3) cp Output_SubDirectory_Importer_2/NewTableHALO.bin .
4) cwl-runner docker_VisIVOFilter_F1.cwl docker-job_VisIVOFilter_F1.yml
5) cp Output_SubDirectory_Filter1_1/density.bin.head .
6) cp Output_SubDirectory_Filter1_2/density.bin .
7) cwl-runner docker_VisIVOFilter_F2.cwl docker-job_VisIVOFilter_F2.yml
8) cp Output_SubDirectory_Filter2_1/NewTableHALOMerge.bin.head .
9) cp Output_SubDirectory_Filter2_2/NewTableHALOMerge.bin .
10) cwl-runner docker_VisIVOViewer_GADGET_Post_F2.cwl docker-job_VisIVOViewer_GADGET_Post_F2.yml


To make this workflow work, in the directory of the workflow "docker_VisIVO_ImpFilterF1F2View_Workflow_GADGET.cwl" the other following files and directories have to be present:
1) paramFile_Imp_Par_MPI.txt (file, needed as input for the VisIVOImporter command)
2) snapdir (directory, needed as input for the VisIVOImporter command)
3) paramFile_Filter_F1.txt (file, needed as input for the first VisIVOFilter command)
4) paramFile_Filter_F2.txt (file, needed as input for the second VisIVOFilter command)
5) tabselection.txt (file, needed as input for the second VisIVOFilter command)
6) paramFile_View_GADGET_Post_F2.txt (file, needed as input for the VisIVOViewer command)
7) docker_VisIVOImporter_Par_OpenMP_MPI_1.cwl (cwl file with the "importer" step of the workflow)
8) docker_VisIVOFilter_F1.cwl (cwl file with the "filter1" step of the workflow)
9) docker_VisIVOFilter_F2.cwl (cwl file with the "filter2" step of the workflow)
10) docker_VisIVOViewer_GADGET_Post_F2.cwl (cwl file with the "viewer" step of the workflow)

Files 1-6 are the inputs of the workflow, as described in the "docker-job_VisIVO_ImpFilterF1F2View_Workflow_GADGET.yml" file.
The first command of the workflow, "VisIVOImporter ...", generates the "NewTableHALO.bin", "NewTableHALO.bin.head", "NewTableGAS.bin", and "NewTableGAS.bin.head" files, in four different subdirectories. The second command of the workflow, "VisIVOFilter ...", generates the "density.bin" and "density.head" files, in two different subdirectories. The third command of the workflow, "VisIVOFilter ...", merges the "density.bin" and the "NewTableHALO.bin" files in the resulting file "NewTableHALOMerge.bin", generating the "NewTableHALOMerge.bin" and "NewTableHALOMerge.bin.head" files in two different subdirectories. The workflow (the last step of the workflow, given by the "VisIVOViewer ..." command) generates as output four .png images from the "NewTableHALOMerge.bin" and "NewTableHALOMerge.bin.head" inputs, "VisIVOServerImage0.png", "VisIVOServerImage1.png", "VisIVOServerImage2.png", and "VisIVOServerImage3.png", that are saved in four different subdirectories. All the subproducts of the workflow do not exist anymore at the end of the workflow execution.

To execute the workflow on singularity, the following command has to be executed:

cwl-runner --streamflow-file streamflow.yml docker_VisIVO_ImpFilterF1F2View_Workflow_GADGET.cwl docker-job_VisIVO_ImpFilterF1F2View_Workflow_GADGET.yml

and the "streamflow.yml" file has to be present in the input directory with the other files listed above.


------------------------
Workflow n. 3.2 (option "pointdistribute" in the VisIVOFilter command): Generate four .png images by running in sequence a VisIVO importer, a VisIVO filter and a VisIVO viewer instances, taking as input GADGET data and running the importer in parallel with MPI + OpenMP.
------------------------
The workflow "docker_VisIVO_ImpFilterView_Workflow_GADGET_PD.cwl" can be executed with the command:

cwl-runner docker_VisIVO_ImpFilterView_Workflow_GADGET_PD.cwl docker-job_VisIVO_ImpFilterView_Workflow_GADGET_PD.yml

contained in the cwl-runner_launch_command_VisIVO_ImpFilterView_Workflow_GADGET_PD.txt file.

This workflow executes, in sequence, a command "VisIVOImporter", a command "VisIVOFilter", and a command "VisIVOViewer" of this kind:
1) export OMP_NUM_THREADS=AA
2) mpirun --np BB --allow-run-as-root VisIVOImporter --fformat gadget --out NewTable --file snapdir/snap_091.0
3) VisIVOFilter --op pointdistribute --resolution X_RES Y_RES Z_RES --points POS_X POS_Y POS_Z --out densityvolume.bin --file NewTableHALO.bin
4) VisIVOViewer --volume --vrendering --vrenderingfield Constant --color --colortable volren_glow --showlut --out img --file densityvolume.bin
In the current implementation, the workflow is executed for OMP_NUM_THREADS=2 and mpirun --np 4 (for the importer) and --resolution 64 64 64 (for the filter).

Specifically, the commands that are executed by the workflow are:
1) export OMP_NUM_THREADS=2 && mpirun --np 4 --allow-run-as-root VisIVOImporter paramFile_Imp_Par_MPI.txt
2) VisIVOFilter paramFile_Filter_PD.txt 
3) VisIVOViewer paramFile_View_GADGET_PD.txt
where each "paramFile" contains the above command specifications.

The steps of the workflow can be executed separately with the commands:
1) cwl-runner docker_VisIVOImporter_Par_OpenMP_MPI_1.cwl docker-job_VisIVOImporter_Par_OpenMP_MPI.yml
2) cp Output_SubDirectory_Importer_1/NewTableHALO.bin.head .
3) cp Output_SubDirectory_Importer_2/NewTableHALO.bin .
4) cwl-runner docker_VisIVOFilter_PD.cwl docker-job_VisIVOFilter_PD.yml
5) cp Output_SubDirectory_Filter_1/densityvolume.bin.head .
6) cp Output_SubDirectory_Filter_2/densityvolume.bin .
7) cwl-runner docker_VisIVO_ImpFilterView_Workflow_GADGET_PD.cwl docker-job_VisIVO_ImpFilterView_Workflow_GADGET_PD.yml


To make this workflow work, in the directory of the workflow "docker_VisIVO_ImpFilterView_Workflow_GADGET_PD.cwl" the other following files and directories have to be present:
1) paramFile_Imp_Par_MPI.txt (file, needed as input for the VisIVOImporter command)
2) snapdir (directory, needed as input for the VisIVOImporter command)
3) paramFile_Filter_PD.txt (file, needed as input for the VisIVOFilter command)
4) paramFile_View_GADGET_PD.txt (file, needed as input for the VisIVOViewer command)
5) docker_VisIVOImporter_Par_OpenMP_MPI_1.cwl (cwl file with the "importer" step of the workflow)
6) docker_VisIVOFilter_PD.cwl (cwl file with the "filter" step of the workflow)
7) docker_VisIVOViewer_GADGET_PD.cwl (cwl file with the "viewer" step of the workflow)

Files 1-4 are the inputs of the workflow, as described in the "docker-job_VisIVO_ImpFilterView_Workflow_GADGET_PD.yml" file.
The first command of the workflow, "VisIVOImporter ...", generates the "NewTableHALO.bin", "NewTableHALO.bin.head", "NewTableGAS.bin", and "NewTableGAS.bin.head" files, in four different subdirectories. The second command of the workflow, "VisIVOFilter ...", generates the "densityvolume.bin" and "densityvolume.head" files, in two different subdirectories. The workflow (the last step of the workflow, given by the "VisIVOViewer ..." command) generates as output four .png images from the "densityvolume.bin" and "densityvolume.bin.head" inputs, "VisIVOServerImage0.png", "VisIVOServerImage1.png", "VisIVOServerImage2.png", and "VisIVOServerImage3.png", that are saved in four different subdirectories. All the subproducts of the workflow do not exist anymore at the end of the workflow execution.

To execute the workflow on singularity, the following command has to be executed:

cwl-runner --streamflow-file streamflow.yml docker_VisIVO_ImpFilterView_Workflow_GADGET_PD.cwl docker-job_VisIVO_ImpFilterView_Workflow_GADGET_PD.yml

and the "streamflow.yml" file has to be present in the input directory with the other files listed above.

------------------------
Workflow n. 4: Generate four .png images and statistics by running a VisIVO importer, two VisIVO filters and a VisIVO viewer instance, taking as input GADGET data and running the importer in parallel with MPI + OpenMP.
------------------------
The workflow "docker_VisIVO_ImpFilterView_Workflow_GADGET_PD.cwl" can be executed with the command:

cwl-runner docker_VisIVO_ImpFilterView_Workflow_GADGET_PD.cwl docker-job_VisIVO_ImpFilterView_Workflow_GADGET_PD.yml

contained in the cwl-runner_launch_command_VisIVO_ImpFilterView_Workflow_GADGET_PD.txt file.

This workflow executes, a command "VisIVOImporter", a command "VisIVOFilter" for the pointdistribute operation, a command "VisIVOFilter" for the statistic operation and a command "VisIVOViewer" of this kind:
1) export OMP_NUM_THREADS=AA
2) mpirun --np BB --allow-run-as-root VisIVOImporter --fformat gadget --out NewTable --file snapdir/snap_091.0
3) VisIVOFilter --op pointdistribute --resolution X_RES Y_RES Z_RES --points POS_X POS_Y POS_Z --out densityvolume.bin --file NewTableHALO.bin
4) VisIVOFilter --op statistic --histogram --out results.txt --file NewTableHALO.bin
5) VisIVOViewer --volume --vrendering --vrenderingfield Constant --color --colortable volren_glow --showlut --out img --file densityvolume.bin
In the current implementation, the workflow is executed for OMP_NUM_THREADS=2 and mpirun --np 4 (for the importer) and --resolution 64 64 64 (for the filter).

Specifically, the commands that are executed by the workflow are:
1) export OMP_NUM_THREADS=2 && mpirun --np 4 --allow-run-as-root VisIVOImporter paramFile_Imp_Par_MPI.txt
2) VisIVOFilter paramFile_Filter_PD.txt 
3) VisIVOFilter paramFile_FilterStat_PD.txt 
4) VisIVOViewer paramFile_View_GADGET_PD.txt
where each "paramFile" contains the above command specifications.

The steps of the workflow can be executed separately with the commands:
1) cwl-runner docker_VisIVOImporter_Par_OpenMP_MPI_1.cwl docker-job_VisIVOImporter_Par_OpenMP_MPI.yml
2) cp Output_SubDirectory_Importer_1/NewTableHALO.bin.head .
3) cp Output_SubDirectory_Importer_2/NewTableHALO.bin .
4) cwl-runner docker_VisIVOFilter_PD.cwl docker-job_VisIVOFilter_PD.yml
5) cp Output_SubDirectory_Filter_1/densityvolume.bin.head .
6) cp Output_SubDirectory_Filter_2/densityvolume.bin .
7) cwl-runner docker_VisIVO_ImpFilterView_Workflow_GADGET_PD.cwl docker-job_VisIVO_ImpFilterView_Workflow_GADGET_PD.yml


To make this workflow work, in the directory of the workflow "docker_VisIVO_ImpFilterView_Workflow_GADGET_PD.cwl" the other following files and directories have to be present:
1) paramFile_Imp_Par_MPI.txt (file, needed as input for the VisIVOImporter command)
2) snapdir (directory, needed as input for the VisIVOImporter command)
3) paramFile_Filter_PD.txt (file, needed as input for the VisIVOFilter command)
4) paramFile_FilterStat_PD.txt (file, needed as input for the other VisIVOFilter command)
5) paramFile_View_GADGET_PD.txt (file, needed as input for the VisIVOViewer command)
6) docker_VisIVOImporter_Par_OpenMP_MPI_1.cwl (cwl file with the "importer" step of the workflow)
7) docker_VisIVOFilter_PD.cwl (cwl file with the "filter" step of the workflow)
8) docker_VisIVOFilterStat_PD.cwl (cwl file with the other "filter" step of the workflow)
9) docker_VisIVOViewer_GADGET_PD.cwl (cwl file with the "viewer" step of the workflow)

Files 1-5 are the inputs of the workflow, as described in the "docker-job_VisIVO_ImpFilterView_Workflow_GADGET_PD.yml" file.
The first command of the workflow, "VisIVOImporter ...", generates the "NewTableHALO.bin", "NewTableHALO.bin.head", "NewTableGAS.bin", and "NewTableGAS.bin.head" files, in four different subdirectories. The second command of the workflow, "VisIVOFilter ...", generates the "densityvolume.bin" and "densityvolume.head" files, in two different subdirectories. The workflow (the last step of the workflow, given by the "VisIVOViewer ..." command) generates as output four .png images from the "densityvolume.bin" and "densityvolume.bin.head" inputs, "VisIVOServerImage0.png", "VisIVOServerImage1.png", "VisIVOServerImage2.png", and "VisIVOServerImage3.png", that are saved in four different subdirectories. All the subproducts of the workflow do not exist anymore at the end of the workflow execution.

To execute the workflow on singularity, the following command has to be executed:

cwl-runner --streamflow-file streamflow.yml docker_VisIVO_ImpFilterView_Workflow_GADGET_PD.cwl docker-job_VisIVO_ImpFilterView_Workflow_GADGET_PD.yml

and the "streamflow.yml" file has to be present in the input directory with the other files listed above.
