#! /usr/bin/python

"""A script for downloading fastq files concurrently.

This script aims to download fastq files concurrently. The SRA accession numbers are stored in different
csv files. The names of the csv files are the BioExperiment IDs.
"""
import os
from multiprocessing import Pool

# Path to the directory in which the fastq files are stored
DATA_PATH = "/home/mali/study/Project/Hempel/raw_data"
def read_csv(csv_path):
    """Reads in a csv file.

    Parameters
    ----------
    csv_path : str
        A str refers to a path to the csv file.

    Returns
    -------
    List
        A list contains the SRA accession numbers
    """
    with open(csv_path, "r") as file:
        tmp_list = file.read().replace("\n", "").split(",")
    return tmp_list

def read_txt(txt_path):
    with open(txt_path, "r") as file:
        tmp_list = file.read().strip().split("\n")
    return tmp_list

def dump_fastq(sra_number):
    """The function prefetches and dumps a sra file with the given sra_number

    Parameters
    ----------
    sra_number : str
        A string refers to a SRA accession number.
    """
    # mkdir_cmd = f"mkdir {sra_path}"
    # os.system(mkdir_cmd)
    prefetch_cmd = f"prefetch {sra_number} -O {DATA_PATH}"
    os.system(prefetch_cmd)
    os.system(f"echo {sra_number} prefetched")

    sra_path = os.path.join(DATA_PATH, sra_number)
    fasterq_dump_cmd = f"fasterq-dump {sra_path} -O {sra_path}"
    os.system(fasterq_dump_cmd)
    os.system(f"echo {sra_number} dumped")

    fastq_path = os.path.join(sra_path, "*.fastq")
    os.system(f"echo gzip {fastq_path}")
    gzip_cmd = f"gzip {fastq_path}"
    os.system(gzip_cmd)

    # Remove the SRA file
    SRA_path = os.path.join(sra_path, f"{sra_number}.sra")
    SRA_remove_cmd = f"rm {SRA_path}"
    os.system(SRA_remove_cmd)

dump_list = read_txt("sra_files.txt")
print(f"{len(dump_list)} files are going to dump.")

with Pool(3) as pool:
    pool.map(dump_fastq, dump_list)