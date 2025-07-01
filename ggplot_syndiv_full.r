library(ggplot2)
library(RColorBrewer)

args <- commandArgs(trailingOnly = TRUE)
div_file <- args[1]
div_file2 <- args[2]

generate_plot <- function(div_file, cent_file, div_file2) {
  
  div <- read.table(div_file)
  div5kb <- read.table(div_file2)
  
  chrs <- unique(div[,1])
  
  m <- 163179969
  step <- 50000
  unit <- step * 20
  
  for (chr in chrs) {
    
    chr_div <- div[div[,1] == chr, ]
    chr_div5kb <- div5kb[div5kb[,1] == chr, ]
    
    p <- ggplot() +
      geom_line(data = chr_div5kb, aes(x = V4 / 1000, y = V5), color = "gray80", size = 0.2) +
      geom_hline(yintercept = 0.25, color = "seagreen", linetype = "dashed", size = 0.3) +
      geom_hline(yintercept = 0.50, color = "red", linetype = "dashed", size = 0.3) +
      geom_line(data = chr_div, aes(x = V4 / 20, y = V5), color = "darkorange2", size = 0.2) +
      labs(x = paste(chr, "(Mb)"), y = "SynDiv") +  
      theme_minimal() +
      theme(
        axis.text = element_text(size = 10, color = "black"),
        axis.title = element_text(size = 14),
        panel.background = element_rect(fill = "white", color = NA),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),  
        axis.line = element_line(color = "black", size = 0.5), 
        axis.ticks = element_line(color = "black", size = 0.5),  
        aspect.ratio = 1/4
      ) +
      scale_x_continuous(limits = c(0, m %/% unit), breaks = seq(0, 160, by = 20)) +
      scale_y_continuous(limits = c(0, 1.0), breaks = seq(0, 1.0, by = 0.2))
    
    print(p)
  }
}

generate_plot(div_file, cent_file, div_file2)
