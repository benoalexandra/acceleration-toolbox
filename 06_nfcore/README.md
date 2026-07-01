# *nf-core*


<img width="500" alt="image" src="https://github.com/user-attachments/assets/942aaaad-9418-4c50-9142-5803967c00a9" />

## 1. Background: The nf-core Initiative

In the era of massive genomics data, reproducibility and scalability are paramount. While **Nextflow** provides a robust domain-specific language (DSL) for writing scalable workflows, researchers often found themselves "reinventing the wheel" by writing their own custom RNA-seq, ChIP-seq, or WGS pipelines. 

**nf-core** was born out of the need to standardize these efforts. It is a community-driven project to collect a curated set of bioinformatics analysis pipelines built using Nextflow. 

**Key Principles of nf-core:**
* **Reproducibility:** Ensuring that data analyzed today will yield the exact same results years from now, regardless of the compute environment.
* **Portability:** Write once, run anywhere. Pipelines run seamlessly on a laptop, a university HPC cluster, or public clouds (AWS, GCP, Azure).
* **Community:** Developed collaboratively by institutions worldwide, ensuring pipelines represent the current best practices in bioinformatics.


---

## 2. The nf-core Platform & Infrastructure

The power of nf-core lies in how it abstracts the underlying computational platform, allowing workflow managers to focus on data rather than IT configuration.

### Containerization
Every tool used in an nf-core pipeline is containerized. nf-core mandates that pipelines support multiple software packaging tools:
* **Docker:** Ideal for local development and cloud execution.
* **Singularity / Apptainer:** The standard for High-Performance Computing (HPC) clusters due to its secure user-space execution.
* **Conda:** Provided as a fallback, though containers are highly preferred for strict reproducibility.

### Execution Environments
Through Nextflow's abstraction, an nf-core pipeline can be deployed on various infrastructures simply by changing the `-profile` flag:
* **Local:** Executing directly on a single machine.
* **HPC Schedulers:** Native integration with Slurm, PBS, SGE, LSF.
* **Cloud Batch Services:** AWS Batch, Google Cloud Life Sciences, Azure Batch.
* **Kubernetes:** For cloud-native orchestration.

### Nextflow Tower (Seqera Platform)
For enterprise workflow managers, nf-core pipelines integrate natively with Seqera Platform (formerly Nextflow Tower), providing a GUI for launching, monitoring, and auditing pipeline runs across multiple compute environments.
<img width="1335" height="619" alt="image" src="https://github.com/user-attachments/assets/2def7194-a292-4494-bc4a-3c3767ad4191" />


### Getting Started Tutorial
[nf-core/demo](https://nf-co.re/docs/get_started/run-your-first-pipeline)

---

## 3. Standardized Workflows

What makes an nf-core pipeline different from a standard Nextflow script? **Strict standardization.**

To be accepted into the nf-core repository, a pipeline must pass rigorous automated testing and adhere to strict guidelines:
1.  **Continuous Integration (CI):** Every commit triggers GitHub Actions that run the pipeline on minimal test datasets to ensure no code breaks the workflow.
2.  **Linting:** The `nf-core lint` tool enforces code formatting, standard parameter naming (e.g., always using `--input` for input files, `--outdir` for output directory), and documentation standards.
3.  **Standardized Output:** All pipelines generate comprehensive MultiQC reports summarizing the run, software versions, and primary QC metrics.
4.  **Stable Releases:** Pipelines are versioned using Git tags (e.g., `3.10.1`). Users are encouraged to run a specific release (using `-r`) rather than the `master` branch to guarantee long-term reproducibility.

**List of nf-core pipelines:**
[nf-core/pipelines](https://nf-co.re/pipelines/)

<img width="1652" height="878" alt="image" src="https://github.com/user-attachments/assets/d54b0edd-ba8d-4845-97a7-a452d7f7225e" />

---

## 4. nf-core Usage: The Command Line Interface

While Nextflow handles the execution, the nf-core tools Python package provides a powerful Command Line Interface (CLI) designed to help workflow managers discover, configure, and deploy these standardized pipelines.

The `nf-core` Python package is the primary command-line tool for interacting with the ecosystem.

**Installation:**
The nf-core CLI is built in Python and can be easily installed via pip or conda:

```{bash}
# Using pip
pip install nf-core

# Using conda (creates an isolated environment)
conda create -n nf-core python=3.10 nf-core -c bioconda
conda activate nf-core
```

**Essential CLI commands**
- ```nf-core list```: Displays a dynamically updated list of all available pipelines in the nf-core repository. It shows the latest stable release version, when it was last updated, and whether it has been downloaded locally.
  - > Tip: Use ```nf-core list rnaseq``` to filter for specific keywords.
- ```nf-core launch <pipeline>```: Instead of manually writing long bash scripts with dozens of --parameters, this command starts an interactive, web-based (or CLI-based) wizard. It walks you through every available parameter, validates your inputs, and generates a ```params.json``` file to safely launch the run.
- ```nf-core download <pipeline>```: Essential for institutions with strict security protocols. This command downloads the pipeline code, the exact institutional configuration files, and even pulls the required Docker/Singularity container images for offline, air-gapped execution.

<img width="1378" height="493" alt="image" src="https://github.com/user-attachments/assets/eb3ea00d-1d9a-41cc-ae87-214b8c4056bc" />


## 5. Example Run Analysis: ```nf-core/rnaseq```

To demonstrate the power of the platform, we will walk through setting up and running nf-core/rnaseq, the community's flagship pipeline for RNA sequencing analysis. It handles everything from raw read QC and adapter trimming to alignment (STAR) and transcript-level quantification (Salmon).

### **Step 1** Prepare the Sample Sheet

```nf-core``` pipelines utilize a strict, standardized ```CSV``` format for data input to ensure metadata is passed correctly.
Create a file named ```samplesheet.csv```. It must contain the exact headers: 
- ```sample```,
- ```fastq_1```,
- ```fastq_2``` and
- ```strandedness```.
