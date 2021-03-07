# CMEE 2020 HPC excercises R code main proforma
# you don't HAVE to use this but it will be very helpful.  If you opt to write everything yourself from scratch please ensure you use EXACTLY the same function and parameter names and beware that you may loose marks if it doesn't work properly because of not using the proforma.

name <- "Jingkai Sun"
preferred_name <- "Kyle"
email <- "jingkai.sun20@imperial.ac.uk"
username <- "ks3020"
personal_speciation_rate <- 0.0052497

# please remember *not* to clear the workspace here, or anywhere in this file. If you do, it'll wipe out your username information that you entered just above, and when you use this file as a 'toolbox' as intended it'll also wipe away everything you're doing outside of the toolbox.  For example, it would wipe away any automarking code that may be running and that would be annoying!
library(ggplot2)
# Question 1
species_richness <- function(community = c(1,4,4,5,1,6,1)){
  return(length(unique(community)))
}

# Question 2
init_community_max <- function(size = 7){
  return(seq(1, size))
}

# Question 3
init_community_min <- function(size = 4){
  return(rep(1, size))
}

# Question 4
choose_two <- function(max_value = 4){
  return(sample(1:max_value, 2, replace = FALSE))
}

# Question 5
neutral_step <- function(community = c(10,5,13)){
  indexes <- choose_two(length(community))
  community[indexes[1]] <- community[indexes[2]]
  return(community)
}

# Question 6
neutral_generation <- function(community = init_community_max(5)) {
  num <- round(length(community) / 2)
  i <- 0
  while(i <= num) {
    i <- i + 1
    community <- neutral_step(community)
  }
  return(community)
}

# Question 7
neutral_time_series <- function(community = init_community_max(7), duration = 20)  {
  output <- species_richness(community)
  for (i in 1:duration + 1){
    community <- neutral_generation(community)
    gen_vec <- species_richness(community)
    output <- c(output, gen_vec)
  }
  return(output)
}

# Question 8
question_8 <- function() {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  time <- seq(0, 200)
  number <- neutral_time_series(init_community_max(100), 200)
  plot(time, number, type = "l", xlab = "time(Generations)", ylab = "Number of Species")
  title("Time series graph of neutral simulation")
  return("The richness of species will converge to 1, because there is no new species entering into the system.")
}

# Question 9
neutral_step_speciation <- function(community = c(10, 15, 13), speciation_rate = personal_speciation_rate)  {
  indexes <- choose_two(length(community))
  rate <- runif(1)
  if (rate > speciation_rate){
    community[indexes[1]] <- community[indexes[2]]
  }else{
    community[indexes[1]] <- max(community) + 1
  }
  return(community)
}

# Question 10
neutral_generation_speciation <- function(community = c(10, 15, 13),speciation_rate = 0.2)  {
  num <- round(length(community) / 2)
  i <- 0
  while (i <= num) {
    i <- i + 1
    community <- neutral_step_speciation(community, speciation_rate)
  }
  return(community)
}

# Question 11
neutral_time_series_speciation <- function(community = init_community_max(7),speciation_rate = 0.2,duration = 20)  {
  richness <- species_richness(community)
  for (i in 1:duration) {
    community <- neutral_generation_speciation(community, speciation_rate)
    richness <- c(richness, species_richness(community))
  }
  return(richness)
}

# Question 12
question_12 <- function()  {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  time <- seq(0, 200)
  number_max <- neutral_time_series_speciation(init_community_max(100), 0.1, 200)
  number_min <- neutral_time_series_speciation(init_community_min(100), 0.1, 200)
  df <- data.frame(time = rep(time, 2), species.number = c(number_max, number_min), 
                   Types = c(rep("Init Community Max(100)", 201), rep("Init Community Min(100)", 201)))
  p <- ggplot(data = df, aes(x = time, y = species.number, colour = Types)) +
    geom_line() +
    theme_classic() +
    theme(aspect.ratio = 1) +
    theme(legend.position = "bottom") +
    xlab("Time (Generations)") +
    ylab("Number of Species") + 
    ggtitle("Species Richeness of Neutral Simulation") +
    theme(axis.title = element_text(size = 11, face = "bold"),
          plot.title = element_text(size = 14, face = "bold"))
  
  plot(p)
  return("Two lines with inital states given by two different init 
  functions both flucatuate between 20 and 40 after waiting a long period,
  which reached a dynamic equlibrium. This beacause a new specie entered into the system,
  every step a individual died, there is 10% of probability that new specie will replace the gap
  to keep the same number of the community.")
}

# Question 13
species_abundance <- function(community = c(1, 1, 1, 5, 3, 6, 5, 6, 1, 1, 6, 6, 6, 6, 100, 101, 42)) {
  return(sort(as.vector(table(community)), decreasing = TRUE))
}

# Question 14
octaves <- function(abundance_vector = c(100, 64, 63, 5, 4, 3, 2, 2, 1, 1, 1, 1)) {
  freq <- tabulate(abundance_vector)
  bin <- c()
  times <- floor(log2(max(abundance_vector)))
  i <- 0
  while (i < times){
    i <- i + 1
    number <- sum(freq[(2 ** (i-1)):(2 ** i - 1)])
    bin <- c(bin, number)
  }
  bin <- c(bin, sum(freq) - sum(bin))
  return(bin)
}

# Question 15
sum_vect <- function(x = c(1, 3, 5, 8, 9, 8), y = c(1, 0, 5, 2)) {
  if (length(x) > length(y)){
    y <- c(y, rep(0, length(x) - length(y)))
  } else if(length(x) < length(y)){
    x <- c(x, rep(0, length(y) - length(x)))
  }
  return(x + y)
}

# Question 16 
question_16 <- function()  {
  # clear any existing graphs and plot your graph within the R window
  # Record species abundance octave vector in burn in vector
  graphics.off()
  library(ggplot2)
  community_max <- neutral_generation_speciation(init_community_max(100), 0.1)
  community_min <- neutral_generation_speciation(init_community_min(100), 0.1)
  for (i in 1:200){
    community_max <- neutral_generation_speciation(community_max, 0.1)
    community_min <- neutral_generation_speciation(community_min, 0.1)
  } 
  oct_max <- octaves(species_abundance(community_max))
  oct_min <- octaves(species_abundance(community_min))

  # Loop 20 periods every time
  # start = proc.time()
  i <- 0
  j <- 0
  while (i <= 2000){
    i <- i + 1
    community_max <- neutral_generation_speciation(community_max, 0.1)
    community_min <- neutral_generation_speciation(community_min, 0.1)
    if (i %% 20 == 0){
      j <- j + 1
      oct_max <- sum_vect(oct_max, octaves(species_abundance(community_max)))
      oct_min <- sum_vect(oct_min, octaves(species_abundance(community_min)))
    }
  }
  # print(proc.time() - start)
  oct_max_mean <- oct_max/(j + 1)
  oct_min_mean <- oct_min/(j + 1)

  df <- data.frame(Ranges = c("1", "2~3", "4~7", "8~15", "16~31", "32~63", "1", "2~3", "4~7", "8~15", "16~31", "32~63"),
                        values = c(oct_max_mean, oct_min_mean),
                        type = c(rep("Octave_max", 6), rep("Octave_min", 6)))

  df$Ranges <- factor(df$Ranges, levels = unique(df$Ranges))
  # str(df)
  p <- ggplot(data = df, aes(x = Ranges, y = values, fill = type)) + 
    geom_bar(stat = "identity", position = "dodge") +
    theme_classic() + 
    theme(legend.position = "bottom") + 
    xlab("Octaves") + 
    ylab("Number of Species") +
    ggtitle("Species Octaves of Neutral Simulation") +
    theme(axis.title = element_text(size = 11, face = "bold"),
          plot.title = element_text(size = 14, face = "bold"))
  
  plot(p)

  return("Because of reaching the dynamic equilibrium, the abundance octaves between high and low initial diversity are almost the same.")
}

# Question 17
cluster_run <- function(speciation_rate = personal_speciation_rate, size = 500, wall_time = 5, interval_rich = 1, 
                        interval_oct = size / 10, burn_in_generations = 8 * size, output_file_name = "my_test_file_1.rda")  
{
  start <- proc.time()
  community <- init_community_min(size)
  richness <- species_richness(community)
  
  for (j in 1:burn_in_generations){
    community <- neutral_generation_speciation(community, speciation_rate)
    if (j %% interval_rich == 0) {richness <- c(richness, species_richness(community))}
  }
  
  i <- 0
  oct <- list(octaves(species_abundance(community)))
  while (TRUE){
    i <- i + 1
    community <- neutral_generation_speciation(community, speciation_rate)
    if (i %% interval_oct == 0) {oct[[(i/interval_oct) + 1]] <- octaves(species_abundance(community))}
    final_time_min <- as.double((proc.time() - start) / 60)[3]
    if (final_time_min >= wall_time) break
  }
  save(richness, oct, community, final_time_min, speciation_rate, size, wall_time,
  interval_rich, interval_oct, burn_in_generations, file = output_file_name)
}

# Questions 18 and 19 involve writing code elsewhere to run your simulations on the cluster

# Question 20 
process_cluster_results <- function()  {
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
      # print(i)
      combined_results <- c(combined_results, list(sum_size / 25))
      sum_abundance <- c()
      sum_size <- c()
    }
    # save results to an .rda file
    save(combined_results, file = "combined_results.rda")
  }
}

plot_cluster_results <- function()  {
    # clear any existing graphs and plot your graph within the R window
    graphics.off()
    # load combined_results from your rda file
    # plot the graphs
    # graphics.off()
    load("combined_results.rda")
    names <- c()
    for (n in 1:12){
      if (n == 1){
        names <- c(names, "1")
      } else {
        names <- c(names, paste(2^(n-1),"~",2^n-1, sep = ""))
      }
    }
    
    df <- data.frame(Ranges = c(names[1:9], names[1:10], names[1:11], names[1:11]),
                     Octaves = c(combined_results[[1]], combined_results[[2]], combined_results[[3]], combined_results[[4]]),
                     Sizes = c(rep("Size = 500 Simulation", 9), rep("Size = 1000 Simulation", 10), rep("Size = 2500 Simulation", 11), rep("Size = 5000 Simulation", 11)))
    
    df$Ranges <- factor(df$Ranges, levels = unique(df$Ranges))
    df$Sizes <- factor(df$Sizes, levels = unique(df$Sizes))
    
    p <- ggplot(df, aes(x = Ranges, y = Octaves, fill = Sizes)) +
          geom_bar(stat = "identity") +
          facet_grid(Sizes ~ ., scales = "free") +
          theme_classic() +
          theme(legend.position = "bottom") +
          xlab("Intervals") +
          ylab("Number of Species") +
          ggtitle("Mean Species Abundance Octave of Neutral Simulation") +
          theme(axis.title = element_text(size = 11, face = "bold"),
                plot.title = element_text(size = 14, face = "bold"))
    
    
    plot(p)
    return(combined_results)
}

# Question 21
question_21 <- function()  {
  dimension <- log(8)/log(3)
  return(list(round(dimension, 3), " Firstly, this big square is consist of 8 small squares, so the size should be 8. Then, a side of big square is consist of 3 squares, so the width of the big square should be 3. Therefore, the dimension should be log(8)/log(3)."))
}

# Question 22
question_22 <- function()  {
  dimension <- log(20)/log(3)
  return(list(round(dimension, 3), " Firstly, this big cube has 6 faces, including 8 small squares each face. Hence the cube is consist of 20 small cubes, which is the size of the big cube. The width is also 3. Therefore, the dimension can be computed by log(20)/log(3)"))
}

# Question 23
chaos_game <- function()  {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  X <- c(0, 0)
  A <- c(0, 0)
  B <- c(3, 4)
  C <- c(4, 1)
  points <- list(A, B, C)
  df <- data.frame(rbind(A, B, C))
  plot(df$X1, df$X2, type = "p", col = "red", xlab = "x", ylab = "y")
  lines(X[1], X[2], cex = 0.8, type = "p", col = "blue", pch = 16)
  title("Chaos Game")
  for (i in 1:2500){
    X <- (X + sample(points, 1)[[1]])/2
    lines(X[1], X[2], cex = 0.8, type = "p", col = "blue", pch = 16)
    text(0, 0.2, labels = "A")
    text(2.9, 4, labels = "B")
    text(4.05, 1.3, labels = "C")
  }
  return("The fractals will continue repeating within the area consisted of three points")
}

# Question 24
turtle <- function(start_position = c(0, 0), direction = pi/3, length = 5)  {
  end_points <- c(start_position[1] + length * cos(direction),
                  start_position[2] + length * sin(direction))
  lines(c(start_position[1], end_points[1]), c(start_position[2], end_points[2]), type = "l")
  return(end_points) # you should return your endpoint here.
}

# Question 25
elbow <- function(start_position = c(0,0), direction = pi/3, length = 4)  {
  end_position <- turtle(start_position, direction, length)
  turtle(end_position, direction - pi/4, 0.95 * length)
}

# Question 26
spiral <- function(start_position = c(5, 5), direction = pi/3, length = 1)  {
  end_position <- turtle(start_position, direction, length)
  if (length >= 0.001) spiral(end_position, direction - pi/4, 0.95 * length)
  return("The parameters of the line will keep changing, so that a spiral will be displayed finally")
}

# Question 27
draw_spiral <- function()  {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  plot(1, type="n", xlab="", ylab="", xlim=c(4, 8), ylim=c(3, 7))
  spiral()
}

# Question 28
tree <- function(start_position = c(5, 5), direction = pi/2, length = 1)  {
  # clear any existing graphs and plot your graph within the R window
  turtle(start_position, direction, length)
  end_position <- turtle(start_position, direction, length)
  if (length >= 0.01) tree(end_position, direction - pi/4, 0.65 * length)
  if (length >= 0.01) tree(end_position, direction + pi/4, 0.65 * length)
}

draw_tree <- function()  {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  plot(1, type="n", xlab="", ylab="", xlim=c(3, 7), ylim=c(4.8, 8))
  tree()
}

# Question 29
fern <- function(start_position = c(5, 5), direction = pi/2, length = 2)  {
  end_position <- turtle(start_position, direction, length)
  if (length >= 0.01) fern(end_position, direction + pi/4, 0.38 * length)
  if (length >= 0.01) fern(end_position, direction, 0.87 * length)
}
draw_fern <- function()  {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  plot(1, type="n", xlab="", ylab="", xlim=c(1, 10), ylim=c(4.5, 21))
  fern()
}

# Question 30
fern2 <- function(start_position = c(5, 5), direction = pi/2, length = 2, dir = 1)  {
  endpoint = turtle(start_position, direction, length)
  if (length >= 0.01){
    fern2(endpoint, direction, 0.87 * length, -dir)
    fern2(endpoint, direction + dir * pi/4, 0.38 * length, dir)
  } 
}

draw_fern2 <- function()  {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  plot(1, xlab="", ylab="", xlim=c(1, 8.5), ylim=c(4.5, 21))
  fern2()
}

# Challenge questions - these are optional, substantially harder, and a maximum of 16% is available for doing them.  

# Challenge question A
Challenge_A <- function() {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  time <- seq(0, 200)
  richness_max <- matrix(nrow = 30, ncol = 201, data = NA)
  richness_min <- matrix(nrow = 30, ncol = 201, data = NA)
  for (i in seq(1, 30)){
    richness_max[i,] <- neutral_time_series_speciation(init_community_max(100), 0.1, 200)
    richness_min[i,] <- neutral_time_series_speciation(init_community_min(100), 0.1, 200)
  }
  
  errMax_upper <- apply(richness_max, 2, function(x){ qnorm(0.986, mean = mean(x), sd = sd(x)) })
  errMax_lower <- apply(richness_max, 2, function(x){ qnorm(0.014, mean = mean(x), sd = sd(x)) })
  
  errMin_upper <- apply(richness_min, 2, function(x){ qnorm(0.986, mean = mean(x), sd = sd(x)) })
  errMin_lower <- apply(richness_min, 2, function(x){ qnorm(0.014, mean = mean(x), sd = sd(x)) })
  
  richness_max <- apply(richness_max, 2, mean)
  richness_min <- apply(richness_min, 2, mean)
  
  df <- data.frame(time = rep(time, 2), species.number = c(richness_max, richness_min),
                   CI.upper = c(errMax_upper, errMin_upper), CI.lower = c(errMax_lower, errMin_lower),
                   Types = c(rep("Init Community Max(100)", 201), rep("Init Community Min(100)", 201)))
  
  p <- ggplot(data = df, aes(x = time, y = species.number, colour = Types)) +
    geom_point() +
    theme_classic() +
    geom_ribbon(aes(ymin = CI.lower, ymax = CI.upper), alpha = 0.2) +
    theme(aspect.ratio = 1) +
    theme(legend.position = "bottom") +
    annotate("text", label = "C", x = 30, y = 25, size = 6, colour = "black", fontface = "bold") +
    ggtitle("Mean Speices Richness with 97.2% Confidence Interval") +
    xlab("Time (Generations)") +
    ylab("Number of Species") + 
    theme(axis.title = element_text(size = 11, face = "bold"), 
          plot.title = element_text(size = 16, face = "bold"))
  
  plot(p)
}

# Challenge question B
Challenge_B <- function() {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  mean_richness <- c()
  mean_richness_values <- c()
  series <- c()
  time_series <- c()
  i <- 0
  while (i < 10){
    i <- i + 1
    community <- replicate(100, sample(2 ** (i + 1), 1))
    for (j in 1:30){
      richness <- neutral_time_series_speciation(community, 0.1, 100)
      mean_richness <- sum_vect(mean_richness, richness)
    }
    mean_richness <- mean_richness / j
    mean_richness_values <- c(mean_richness_values, mean_richness)
    time_series <- c(time_series, seq(1, length(mean_richness)))
    series <- c(series, rep(species_richness(community), length(mean_richness)))
  }
  
  df <- data.frame(time = time_series, species.number = mean_richness_values, Types = factor(series, levels = unique(series)))
  
  p <- ggplot(data = df, aes(x = time, y = species.number, colour = Types)) +
    geom_line() +
    theme_classic() +
    theme(aspect.ratio = 1) +
    theme(legend.position = "bottom") +
    ggtitle("Species Richness from Average of Different Initial Numbers") +
    xlab("Time (Generations)") +
    ylab("Number of Species") + 
    theme(axis.title = element_text(size = 11, face = "bold"),
          plot.title = element_text(size = 16, face = "bold"))
  
  plot(p)
}

# Challenge question C
Challenge_C <- function() {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  mean_richness <- c( )
  combined_results <- list()  #create your list output here to return
  i <- 0
  while(i < 100){
    i <- i + 1
    fileName <- paste("Results/ks3020_result", i, ".rda", sep = "")
    load(fileName)
    # Obtain mean octaves for each abundance octave
    mean_richness <- sum_vect(mean_richness, richness)
    if (i %% 25 == 0){
      combined_results <- c(combined_results, list(mean_richness / 25))
      mean_richness <- c()
    }
  }
  
  gen1_time <- seq(1, 4001)
  gen2_time <- seq(1, 8001)
  gen3_time <- seq(1, 20001)
  gen4_time <- seq(1, 40001)
  
  df <- data.frame(time=c(gen1_time, gen2_time, gen3_time, gen4_time),
                   richness=c(combined_results[[1]], combined_results[[2]], combined_results[[3]], combined_results[[4]]),
                   Sizes=c(rep("Size = 500 Simulation", 4001), rep("Size = 1000 Simulation", 8001), rep("Size = 2500 Simulation", 20001), rep("Size = 5000 Simulation", 40001)))
  
  p <- ggplot(df, aes(x = time, y = richness, colour = Sizes)) + 
    # geom_bar(stat = "identity") + 
    geom_line() +
    facet_wrap(Sizes ~ ., scales = "free") + 
    theme_classic() +
    theme(legend.position = "bottom") +
    xlab("Generations") + 
    ylab("Mean Species Richness")
  
  plot(p)
}

# Challenge question D
Challenge_D <- function() {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  coalescence <- function(J = 500, v = 0.0052497){
    lineages <- init_community_min(J)
    abundances <- c()
    N <- J
    theta <- v * (J - 1) / (1 - v)
    while (N > 1) {
      randnum <- runif(1)
      rand <- sample(N, 2)
      j <- rand[1]
      i <- rand[2]
      if (randnum < theta / (theta + N - 1)){
        abundances <- c(abundances, lineages[j])
      } else {
        lineages[i] <- lineages[i] + lineages[j]
      }
      lineages <- lineages[-j]
      N <- N - 1
    }
    abundances <- c(abundances, lineages)
    return(abundances)
  }
  
  # Octaves using Coalscence
  start <- proc.time()
  oct_mean <- c()
  for (i in 1:886){
    oct_mean <- sum_vect(oct_mean, octaves(coalescence(J = 5000, v = 0.0052497)))
  }
  oct_mean_coal <- oct_mean/886
  coal_time <- (proc.time() - start)
  coal_time <- coal_time / 60
  
  # Octaves using Cluster
  load("Results/ks3020_result79.rda")
  i <- 79
  sum_abundance <- c( )
  fileName <- paste("Results/ks3020_result", i, ".rda", sep = "")
  load(fileName)
  # Obtain mean octaves for each abundance octave
  for (j in 1:length(oct)){
    sum_abundance <- sum_vect(sum_abundance, oct[[j]])
  }
  oct_mean <- sum_abundance/length(oct)
  
  names <- c()
  for (n in 1:12){
    if (n == 1){
      names <- c(names, "1")
    } else {
      names <- c(names, paste(2^(n-1),"~",2^n-1, sep = ""))
    }
  }
  
  df <- data.frame(Ranges = c(names[1:length(oct_mean)], names[1:length(oct_mean_coal)]),
                   Oct.values = c(oct_mean, oct_mean_coal),
                   Types = c(rep("Octaves(Cluster)", length(oct_mean)), rep("Ocataves(Coalescence)", length(oct_mean_coal))))
  
  df$Ranges <- factor(df$Ranges, unique(df$Ranges))
  
  p <- ggplot(df, aes(x = Ranges, y = Oct.values, fill = Types)) + 
    geom_bar(stat = "identity", position = "dodge") + 
    theme_classic() +
    theme(legend.position = "bottom") + 
    xlab("Intervals") + 
    ylab("Number of Species") + 
    ggtitle("Comprison of Octaves from Cluster and Coalescence") +
    theme(plot.title = element_text(size = 20, face = "bold"), 
          axis.title = element_text(size = 14, face = "bold"), 
          axis.text = element_text(size = 12))
  
  plot(p)
  return(paste("The coalescence simulation takes", coal_time[3], "minutes to run, while the cluster simulation takes", final_time_min, "minutes to run. "))
}

# Challenge question E
Challenge_E <- function() {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  
  par(mfrow = c(1, 2))
  X <- c(4, 1)
  ## Contruct equilateral triangle
  ################################
  A <- c(0, 0)
  B <- c(2, sqrt(12))
  C <- c(4, 0)
  
  points <- list(A, B, C)
  df <- data.frame(rbind(A, B, C))
  plot(df$X1, df$X2, type = "p", col = "red", xlab = "x", ylab = "y", xlim=c(0, 4), ylim=c(0, 4))
  lines(X[1], X[2], cex = 0.8, type = "p", col = "magenta", pch = 16)
  title("Chaos Game")
  # while (TRUE){
  #   X <- (X + sample(points, 1)[[1]])/2
  #   lines(X[1], X[2], cex = 0.8, type = "p", col = "red", pch = 16)
  #   if(X[1] == 0 && X[2] == 0) break
  # }
  for (i in 1:2000){
    X <- (X + sample(points, 1)[[1]])/2
    if (i < 50) {
      lines(X[1], X[2], cex = 0.8, type = "p", col = "magenta", pch = 16)
    } else {
      lines(X[1], X[2], cex = 0.8, type = "p", col = "blue", pch = 16)
    }
    text(0, 0.2, labels = "A")
    text(2, 3.8, labels = "B")
    text(4, 0.2, labels = "C")
  }
  ################################
  
  
  ## Consturct rectangle
  ################################
  A <- c(0,0)
  B <- c(0,3)
  C <- c(4,0)
  D <- c(4,3)
  
  points <- list(A, B, C, D)
  df <- data.frame(rbind(A, B, C, D))
  plot(df$X1, df$X2, type = "p", col = "red", xlab = "x", ylab = "y", xlim=c(0, 4), ylim=c(0, 4))
  lines(X[1], X[2], cex = 0.8, type = "p", col = "magenta", pch = 16)
  
  for (i in 1:1500){
    X <- (X + sample(points, 1)[[1]])/2
    if (i < 50) {
      lines(X[1], X[2], cex = 0.8, type = "p", col = "magenta", pch = 16)
    } else {
      lines(X[1], X[2], cex = 0.8, type = "p", col = "blue", pch = 16)
    }
    text(0, -0.1, labels = "A")
    text(0, 3.2, labels = "B")
    text(4, -0.1, labels = "C")
    text(4, 3.2, labels = "D")
  }
  ################################
  
  par(mfrow = c(1, 1))
  
  return("Under the situation of having three points, whatever are coordinates of X set, X will always construct triangle by repeating fractals. Under the situation of having four or more points, there will be the chaos")
}

# Challenge question F
Challenge_F <- function() {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  # To vary the value of e(the line size threshold)
  e <- c(0.1, 0.01, 0.005)
  time_takes <- list()
  
  fern3 <- function(start_position = c(5, 5), direction = pi/2, length = 1, dir = 1, ee = 0.01)  {
    endpoint = turtle(start_position, direction, length)
    if (length >= ee){
      fern3(endpoint, direction, 0.87 * length, -dir, ee)
      fern3(endpoint, direction + dir * pi/4, 0.38 * length, dir, ee)
    } 
  }
  
  draw_fern3 <- function(e)  {
    # clear any existing graphs and plot your graph within the R window
    plot(1, xlab="", ylab="", xlim=c(2.5, 7), ylim=c(4.5, 13))
    fern3(ee=e)
  }
  
  par(mfrow = c(2, 2))
  for (i in e){
    start <- proc.time()
    draw_fern3(e = i)
    end <- (proc.time() - start)[3]
    time_takes <- c(time_takes, list(end))
    title(paste(i, "Threshold"))
  }

  # To experiment with colours
  fern2 <- function(start_position = c(5, 5), direction = pi/2, length = 1, dir = 1, col = "red")  {
    end_points <- c(start_position[1] + length * cos(direction), start_position[2] + length * sin(direction))
    lines(c(start_position[1], end_points[1]), c(start_position[2], end_points[2]), type = "l", col = col)
    if (length >= 0.01){
      if (dir == 1){
        fern2(end_points, direction, 0.87 * length, -dir)
        fern2(end_points, direction + dir * pi/4, 0.38 * length, dir)
      } else {
        fern2(end_points, direction, 0.87 * length, -dir, col = "blue")
        fern2(end_points, direction + dir * pi/4, 0.38 * length, dir, col = "blue")
      }
    } 
  }
  plot(1, xlab="", ylab="", xlim=c(2.5, 7), ylim=c(4.5, 13))
  fern2()
  title("Happy Christmas!")
  
  par(mfrow = c(1, 1))
  return(paste("The function with ", e[1], " threshold takes ", time_takes[[1]], " seconds to run; ", "the function with ", e[2], "threshold takes ", time_takes[[2]], " seconds to run;", "the function with ", e[3], "threshold takes ", time_takes[[3]], " seconds to run.", "As expected, the less values of threshold, the more time spent, the more repetition of fratals as well." ))
}

# Challenge question G should be written in a separate file that has no dependencies on any functions here.


