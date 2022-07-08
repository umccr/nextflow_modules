# UMCCR Nextflow modules

Nextflow DLS2 modules used at UMCCR.

The structure of this repository and individual modules are modelled after
[nf-core/modules](https://github.com/nf-core/modules/) to allow interopability with the `nf-core` CLI tool.

UMCCR Nextflow infrastructure is organised across several locations:

1. [Pipelines](https://github.com/umccr/nextflow_pipelines)
1. [Modules](https://github.com/umccr/nextflow_modules)
1. [Test data](https://github.com/umccr/nextflow_testdata)
1. [Reference data](https://github.com/umccr/reference_data/tree/dev)
1. [AWS infrastructure](https://github.com/umccr/infrastructure/tree/master/cdk/apps/nextflow) (_proposed work_)
1. [ICA infrastructure](https://github.com/umccr/icav2_nextflow_deployer) (_proposed concept_)

## Contents

* [Usage](#usage)
* [Run tests](#run-tests)
* [Run linting](#run-linting)
* [License](#license)

## Usage

List available modules:

```text
$ nf-core modules -g umccr/nextflow_modules -b main list remote

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
│ gripss/germline          │
│ gripss/somatic           │
│ lilac                    │
│ linx/germline            │
│ linx/somatic             │
│ linx/visualiser          │
│ pave/germline            │
│ pave/somatic             │
│ purple                   │
│ sage/germline            │
│ sage/somatic             │
│ sambamba/slice           │
│ teal                     │
└──────────────────────────┘
```

Retrieve information for specific module:

```text
$ nf-core modules -g umccr/nextflow_modules -b main info amber

╭─ Module: amber  ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ Location: ./modules/amber                                                                                                                                                  │
│ 🔧 Tools: AMBER                                                                                                                                                            │
│ 📖 Description: Generate a tumor BAF file for PURPLE copy number fit                                                                                                       │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
                        ╷                                                                                                                                       ╷
 📥 Inputs              │Description                                                                                                                            │   Pattern
╺━━━━━━━━━━━━━━━━━━━━━━━┿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┿━━━━━━━━━━━━╸
  meta  (map)           │Groovy Map containing sample information e.g. [['sample_name', 'tumor']: 'sample_tumor', [['sample_name', 'normal']]: 'sample_normal'] │
╶───────────────────────┼───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┼────────────╴
  tumor_bam  (file)     │Tumor BAM file                                                                                                                         │   *.{bam}
╶───────────────────────┼───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┼────────────╴
  normal_bam  (file)    │Normal BAM file                                                                                                                        │   *.{bam}
╶───────────────────────┼───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┼────────────╴
  tumor_bai  (file)     │Tumor BAI file                                                                                                                         │   *.{bai}
╶───────────────────────┼───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┼────────────╴
  normal_bai  (file)    │Normal BAI file                                                                                                                        │   *.{bai}
╶───────────────────────┼───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┼────────────╴
  loci  (file)          │AMBER loci file                                                                                                                        │*.{vcf.gz}
                        ╵                                                                                                                                       ╵
                        ╷                                                                                                                                       ╷
 📤 Outputs             │Description                                                                                                                            │     Pattern
╺━━━━━━━━━━━━━━━━━━━━━━━┿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┿━━━━━━━━━━━━╸
  meta  (map)           │Groovy Map containing sample information e.g. [['sample_name', 'tumor']: 'sample_tumor', [['sample_name', 'normal']]: 'sample_normal'] │
╶───────────────────────┼───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┼────────────╴
  amber_dir  (directory)│AMBER output directory                                                                                                                 │
╶───────────────────────┼───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┼────────────╴
  versions  (file)      │File containing software versions                                                                                                      │versions.yml
                        ╵                                                                                                                                       ╵

 💻  Installation command: nf-core modules --github-repository umccr/nextflow_modules install amber
```

Install a specific module:

```text
$ nf-core modules -g umccr/nextflow_modules -b main install amber
```

Install a specific module version/commit:

```text
$ nf-core modules -g umccr/nextflow_modules -b main install --sha <my_git_commit_sha> amber
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
> Typically we would use directory URLs to test data hosted on umccr/nextflow_testdata but this only works for files and
> not directories. Many of the tests run required input directories hence we manually stage the test data by cloning the
> umccr/nextflow_testdata manually.

> It is assumed `nextflow`, `docker`, and `pytest` have been installed.

```bash
# Stage test data then run tests
git clone https://github.com/umccr/nextflow_testdata
TMPDIR=~ PROFILE=docker pytest --symlink --kwdof --color=yes
```

## Run linting

```bash
nf-core modules lint -a
```

## License

Software and code in this repository are provided under the [GNU General Public License
v3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) unless otherwise indicated.
