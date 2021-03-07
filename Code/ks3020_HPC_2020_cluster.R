# CMEE 2020 HPC excercises R code HPC run code proforma

rm(list=ls()) # good practice 
graphics.off()
# source("ks3020/ks3020_HPC_2020_main.R")
source("/rds/general/user/ks3020/home/ks3020_HPC_2020_main.R")

speciation_rate <- 0.0052497
# speciation_rate <- 0.0021255
community_size_vec <- c(500, 1000, 2500, 5000)

iter < as.numeric(Sys.getenv("PBS_ARRAY_INDEX"))
# for (i in seq(1, 100, 25)) {
# iter <- 3
if (iter >= 1 && iter <= 25) size <- community_size_vec[1]
if (iter > 25 && iter <= 50) size <- community_size_vec[2]
if (iter > 50 && iter <= 75) size <- community_size_vec[3]
if (iter > 75 && iter <= 100) size <- community_size_vec[4]

set.seed(iter)
cluster_run(speciation_rate = speciation_rate, size = size, wall_time = 5, interval_rich = 1,
interval_oct = size / 10, burn_in_generations = 8 * size, output_file_name = paste("Sandbox/test/ks3020_result", iter, ".rda", sep = ""))