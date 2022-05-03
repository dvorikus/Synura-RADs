# This R script was made for the paper: Skaloud et al.: Incipient speciation in a free-living protist flagellate: disentangling the effects of environment and geography
# The script is free to use without any warranty 
# Author: Petr Dvorak, Palacky University Olomouc, Department of Botany
# details at https://bcm-uga.github.io/pcadapt/articles/pcadapt.html

# package for oulier identification 
library(pcadapt)

# package for oulier identification 
library(qvalue)

# load data in vcf format and convert to pcadapt format
path_to_file <- "/path/to/your/file"
filename <- read.pcadapt(path_to_file, type = "vcf")

# test for the best K
# first large range
x <- pcadapt(input = filename, K = 20)

# plot the results, scree plot
plot(x, option = "screeplot")

# if the scree plot does not produce clearly defined K, it can be defined base on PCA
# define population, it can be list of "POP1", "POP2", ... for each sample which population like Stacks popmap
poplist.int <- c(rep(1, 5), rep(2, 5), rep(3, 5), rep(4, 5), rep(5, 5), rep(6, 5), rep(7, 5), rep(8, 5), rep(9, 5), rep(10, 5))

poplist.names <- c(rep("POP1", 5),rep("POP2", 5),rep("POP3", 5), rep("POP3", 5), rep("POP4", 5), rep("POP5", 5), rep("POP6", 5), rep("POP7", 5), rep("POP8", 5), rep("POP9", 5), rep("POP10", 5))

# some other plots
plot(x, option = "scores", pop = poplist.int)
plot(x, option = "scores", i = 3, j = 4, pop = poplist.int)
plot(x , option = "manhattan")
plot(x, option = "qqplot")

# pcadapt for the best K, K = 5
x5 <- pcadapt(input = filename, K = 5)


# identify ouliers - 3 different ways described https://bcm-uga.github.io/pcadapt/articles/pcadapt.html
# K = 5
qval <- qvalue(x5$pvalues)$qvalues
alpha <- 0.1
outliers5a <- which(qval < alpha)
length(outliers5a)

padj <- p.adjust(x5$pvalues,method="BH")
alpha <- 0.1
outliers5b <- which(padj < alpha)
length(outliers5b)

padj <- p.adjust(x5$pvalues,method="bonferroni")
alpha <- 0.1
outliers5c <- which(padj < alpha)
length(outliers5c)

# writhe list of outlier
write.table(outliers5a, file = "outliers.K5")

