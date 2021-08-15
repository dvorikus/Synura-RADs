
# This R script was made for paper: Skaloud et al.: Incipient speciation in a free-living protist flagellate: disentangling the effects of environment and geography
# The script is free to use withou any warranty 
# Author: Petr Dvorak, Palacky University Olomouc, Department of Botany

# load packages
# package for oulier identification 
library(pcadapt)

# qvalue
library(qvalue)

# load data in vcf format and convert to pcadapt format
path_to_file <- "/path/to/your/file"
filename <- read.pcadapt(path_to_file, type = "vcf")

# test for the Best K
x <- pcadapt(input = filename, K = 20)

# plot result
plot(x, option = "screeplot")
plot(x, option = "screeplot", K = 10)

# define population, it can be list of "POP1", "POP2", ... for each sample which population like Stacks popmap
poplist.int <- c(rep(1, 5), rep(2, 5), rep(3, 5), rep(4, 5), rep(5, 5), rep(6, 5), rep(7, 5), rep(8, 5), rep(9, 5), rep(10, 5))

poplist.names <- c(rep("POP1", 5),rep("POP2", 5),rep("POP3", 5), rep("POP3", 5), rep("POP4", 5), rep("POP5", 5), rep("POP6", 5), rep("POP7", 5), rep("POP8", 5), rep("POP9", 5), rep("POP10", 5))

# some other plots, see documentation of pcadapt
plot(x, option = "scores", pop = poplist.int)

plot(x , option = "manhattan")

plot(x, option = "qqplot")


# identify ouliers, two different ways using package qvalues
qval <- qvalue(x$pvalues)$qvalues
alpha <- 0.1
outliers <- which(qval < alpha)
length(outliers)


padj <- p.adjust(x$pvalues,method="BH")
alpha <- 0.1
outliers2 <- which(padj < alpha)
length(outliers2)

padj <- p.adjust(x$pvalues,method="bonferroni")
alpha <- 0.1
outliers3 <- which(padj < alpha)
length(outliers3)


