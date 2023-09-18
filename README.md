# Subject-specific brain functional fingerprints are preserved during general anesthesia

# Overview
Motivated by clinical needs, we conducted a comprehensive study to explore the effects of anesthesia on cortical functional connectivity at an individual level. 
Our study involved individualized functional analyses of resting-state fMRI data from 14 healthy participants, encompassing both awake and anesthetized states. 
Importantly, each participant underwent extensive 96-minute fMRI scanning, enabling us to capture robust anesthesia-induced changes at the individual level. 

We observed reduced connectivity during anesthesia compared to the awake state, particularly within unimodal networks and across various between-network interactions, indicating a weakened functional integration. Although anesthesia diminished individual differences in functional connectivity, we found that subject-specific functional connectivity fingerprints were well-preserved. To mitigate the effects of anesthesia on brain connectivity, we developed a predictive model that accurately reconstructs functional connectomes in the awake state using data collected under anesthesia. We demonstrated the model's ability to identify disease-specific dysfunctions using data f
rom 29 anesthetized children with autism spectrum disorder (ASD).

# System Requirments

The package is supported for *Linux* and *macOS*. The package has been tested on Linux operating systems. 
+ Linux : Ubuntu (20.04.5)
+ macOS
  
Some softwares should be installed and setted up.

[BrainSector® Cloud](https://app.neuralgalaxy.cn/#/login?r=%2F)：preprocess, you can also use other pipelines to deal with the rsfMRI data

[FreeSurfer](https://surfer.nmr.mgh.harvard.edu/fswiki/DownloadAndInstall): registration and visualization

[FSL](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FslInstallation): registration and visualization

[Connectome Workbench](https://humanconnectome.org/software/get-connectome-workbench): visualization

[Matlab](https://www.mathworks.com/products/matlab.html): statistical analysis
  
# Code
This repository contains a general pipeline for analysis of the publication

[Dissimilarity analysis](https://github.com/IndiLab/AnesFC/tree/main/Codes/dissimilarity_codes): For each vertex on the cortical surface, we compared its connectivity profiles between awake and anesthetized states while controlling for normal variations.

[Variability analysis](https://github.com/IndiLab/AnesFC/tree/main/Codes/variability_codes): To understand how anesthesia affects individual differences in brain functional activity, we utilized a previously reported method to derive a map of inter-individual variability in RSFC while controlling for intra-individual variability.

[HBM model](https://github.com/IndiLab/AnesFC/tree/main/Codes/ASDanes_HBM_Model.txt):
 Anesthetic effects on functional connectivity could obscure the effect of diseases. To address this, we developed a predictive model to estimate the individual functional connectome in the awake state using data collected during the anesthetized state. The model incorporates a nonlinear fitting model and a Hierarchical Bayesian Model (HBM), leveraging prior knowledge about the anesthetic effect on functional networks and inter-individual variability, respectively.

# Data

[Results](https://github.com/IndiLab/AnesFC/tree/main/Data)： you can find the data and results used in this research, including [Similarity](https://github.com/IndiLab/AnesFC/tree/main/Data/Similarity),[Dissimilarity](https://github.com/IndiLab/AnesFC/tree/main/Data/Dissimilarity),[all FC matrix](https://github.com/IndiLab/AnesFC/tree/main/Data/92parcFC) and [Abnormality](https://github.com/IndiLab/AnesFC/tree/main/Data/Abnormality).

# License

This project is covered under the **Apache 2.0 License**.
