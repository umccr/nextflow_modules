# UMCCR Nextflow modules

Nextflow DLS2 modules used at UMCCR.

The structure of this repository and individual modules are modelled after
[nf-core/modules](https://github.com/nf-core/modules/) to allow interopability with the `nf-core` CLI tool.

UMCCR Nextflow infrastructure is organised across several locations:

1. [Pipelines](https://github.com/scwatts/nextflow_pipelines)
1. [Modules](https://github.com/scwatts/nextflow_modules)
1. [Test data](https://github.com/scwatts/nextflow_testdata)
1. [Reference data](https://github.com/umccr/reference_data/tree/dev)
1. [AWS infrastructure](https://github.com/umccr/infrastructure/tree/master/cdk/apps/nextflow) (_planned work_)
1. [ICA infrastructure](https://github.com/umccr/icav2_nextflow_deployer) (_planned concept_)

## Contents

* [Usage](#usage)
* [Run tests](#run-tests)
* [Run linting](#run-linting)
* [License](#license)

## Usage

List available modules:

```text
$ nf-core modules -g scwatts/nextflow_modules -b main list remote

┏━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃ Module Name              ┃
┡━━━━━━━━━━━━━━━━━━━━━━━━━━┩
│ amber                    │
│ cobalt                   │
│ gpgr/linx_report         │
│ gridss/annotate          │
│ gridss/assemble          │
│ gridss/call              │
│ gridss/extract_fragments │
│ gridss/preprocess        │
│ gripss                   │
│ linx/annotation          │
│ linx/visualiser          │
│ purple                   │
└──────────────────────────┘
```

Retrieve information for specific module:

```text
$ nf-core modules -g scwatts/nextflow_modules -b main info amber

╭─ Module: amber  ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ 🌐 Repository: scwatts/nextflow_modules                                                                                             │
│ 🔧 Tools: AMBER                                                                                                                     │
│ 📖 Description: Generate a tumor BAF file for PURPLE copy number fit                                                                │
╰─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
                    ╷                                                                                                      ╷
 📥 Inputs          │Description                                                                                           │   Pattern
╺━━━━━━━━━━━━━━━━━━━┿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┿━━━━━━━━━━╸
  meta  (map)       │Groovy Map containing sample information e.g. [subject_name: 'subject', ['sample_name', 'tumor']:     │
                    │'sample', ['tumor', 'bam']: 'path/to/bam'                                                             │
╶───────────────────┼──────────────────────────────────────────────────────────────────────────────────────────────────────┼──────────╴
  tumor_bam  (file) │BAM file                                                                                              │   *.{bam}
╶───────────────────┼──────────────────────────────────────────────────────────────────────────────────────────────────────┼──────────╴
  normal_bam  (file)│BAM file                                                                                              │   *.{bam}
╶───────────────────┼──────────────────────────────────────────────────────────────────────────────────────────────────────┼──────────╴
  tumor_bai  (file) │BAI file                                                                                              │   *.{bai}
╶───────────────────┼──────────────────────────────────────────────────────────────────────────────────────────────────────┼──────────╴
  normal_bai  (file)│BAI file                                                                                              │   *.{bai}
╶───────────────────┼──────────────────────────────────────────────────────────────────────────────────────────────────────┼──────────╴
  loci  (file)      │AMBER loci file                                                                                       │*.{vcf.gz}
                    ╵                                                                                                      ╵
                        ╷                                                                                                ╷
 📤 Outputs             │Description                                                                                     │     Pattern
╺━━━━━━━━━━━━━━━━━━━━━━━┿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┿━━━━━━━━━━━━╸
  meta  (map)           │Groovy Map containing sample information e.g. [subject_name: 'subject', ['sample_name',         │
                        │'tumor']: 'sample', ['tumor', 'bam']: 'path/to/bam'                                             │
╶───────────────────────┼────────────────────────────────────────────────────────────────────────────────────────────────┼────────────╴
  amber_dir  (directory)│AMBER output directory                                                                          │
╶───────────────────────┼────────────────────────────────────────────────────────────────────────────────────────────────┼────────────╴
  versions  (file)      │File containing software versions                                                               │versions.yml
                        ╵                                                                                                ╵

 💻  Installation command: nf-core modules --github-repository scwatts/nextflow_modules install amber
```

Install a specific module:

```text
$ nf-core modules -g scwatts/nextflow_modules -b main install amber
```

Install a specific module version/commit:

```text
$ nf-core modules -g scwatts/nextflow_modules -b main install --sha <my_git_commit_sha> amber
```

## Run tests

> I have disabled the GH Action test workflow until a suitable solution is determined to provide the required reference
> data to each module; the major problems are (1) insufficient disk on GH Action machines and (2) an inability for
> Nextflow to retrieve files from a DVC remote. Several solutions possible but this is currently a low priority.

Pull GPL reference data:
```bash
git clone https://github.com/umccr/reference_data -b dev reference_data_gitrepo/ && cd reference_data_gitrepo/
dvc pull reference_data/{genomes,hmftools}/ -r storage-s3 && cd ../
ln -s reference_data_gitrepo/reference_data/ reference_data
```

Run tests
> Paths to data in the `nextflow_testdata` repo only work for files but we need to provide input directories. So
> currently we must clone the repo locally and adjust paths.
```bash
# Prepare test data
PREFIX=https://raw.githubusercontent.com/scwatts/nextflow_testdata/main/
sed -i 's#'${PREFIX}'#'$(pwd -P)/nextflow_testdata/'#' $(find tests/modules/ -name main.nf)
git clone https://github.com/scwatts/nextflow_testdata

TMPDIR=~ PROFILE=docker pytest --symlink --kwdof --color=yes
```

## Run linting

```bash
nf-core modules lint -a
```

## License

Software and code in this repository are provided under the [GNU General Public License
v3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) unless otherwise indicated.
