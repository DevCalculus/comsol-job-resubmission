# COMSOL Job Resubmission Script (Compute Canada)

This repository provides a **SLURM batch script** for running and automatically resuming COMSOL Multiphysics jobs on **Compute Canada clusters** (e.g., Narval, Béluga, Graham).  
It uses COMSOL’s recovery mechanism to restart simulations if they are interrupted by time limits or node failures.

---

## 🚀 Features
- Works seamlessly with Compute Canada environments.
- Automatically detects and resumes from recovery files.
- Handles temporary directories and cleanup safely.
- Easily customizable input/output file names.
- Fully compatible with `comsol/6.3` and later.

---

## 🧩 Usage

1. Clone the repository:
   ```bash
   git clone https://github.com/<your-username>/comsol-job-resubmission.git
   cd comsol-job-resubmission
