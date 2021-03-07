rm(list = ls())

library(ggplot2)

# Question 15
sum_vect <- function(x = c(1, 3, 5, 8, 9, 8), y = c(1, 0, 5, 2)) {
  if (length(x) > length(y)){
    y <- c(y, rep(0, length(x) - length(y)))
  } else if(length(x) < length(y)){
    x <- c(x, rep(0, length(y) - length(x)))
  }
  return(x + y)
}

# 
sum_abundance <- c( )
sum_size <- c()
combined_results <- list()  #create your list output here to return
i <- 0
while (i < 100){
  i <- i + 1
  fileName <- paste("Results/ks3020_result", i, ".rda", sep = "")
  load(fileName)
  # Obtain mean octaves for each abundance octave
  for (j in 1:length(oct)){
    sum_abundance <- sum_vect(sum_abundance, oct[[j]])
  }
  oct_mean <- sum_abundance/length(oct)
  sum_abundance <- c()
  sum_size <- sum_vect(sum_size, oct_mean)
  if (i %% 25 == 0){
    print(i)
    combined_results <- c(combined_results, list(sum_size / 25))
    sum_abundance <- c()
    sum_size <- c()
  }
  # save results to an .rda file
  save(combined_results, file = "combined_results.rda")
}
# 
# names <- c()
# for (n in 1:12){
#   if (n == 1){
#     names <- c(names, "1")
#   } else {
#     names <- c(names, paste(2^(n-1),"~",2^n-1, sep = ""))
#   }
# }
# 
# df <- data.frame(Ranges = c(names[1:9], names[1:10], names[1:11], names[1:11]),
#                  Octaves = c(combined_results[[1]], combined_results[[2]], combined_results[[3]], combined_results[[4]]),
#                  Sizes = c(rep("Size = 500 Simulation", 9), rep("Size = 1000 Simulation", 10), rep("Size = 2500 Simulation", 11), rep("Size = 5000 Simulation", 11)))
# 
# df$Ranges <- as.character(df$Ranges)
# df$Ranges <- factor(df$Ranges, levels = unique(df$Ranges))
# 
# df$Sizes <- as.character(df$Sizes)
# df$Sizes <- factor(df$Sizes, levels = unique(df$Sizes))
# 
# ggplot(df, aes(x = Ranges, y = Octaves, fill = Sizes)) +
#   geom_bar(stat = "identity") +
#   facet_grid(Sizes ~ .) +
#   theme(legend.position = "bottom")
# 
load("Sandbox/test/neutral_simulation_3.rda")
load("Results/ks3020_result3.rda")

i <- 3
fileName <- paste("Results/ks3020_result", i, ".rda", sep = "")
load(fileName)
# Obtain mean octaves for each abundance octave
for (j in 1:length(oct)){
  sum_abundance <- sum_vect(sum_abundance, oct[[j]])
}
oct_mean <- sum_abundance/length(oct)

load("Sandbox/test/ks3020_result3.rda")
# load("Week9_HPC/Sandbox/test/ks3020_result3.rda")

  
