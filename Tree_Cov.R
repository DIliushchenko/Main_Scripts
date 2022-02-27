rm(list=ls(all=T))
library(ggtree)
library(ggplot2)
library(treeio)
library(dplyr)
library(ape)



cov_tree = read.tree('anc.treefile')
grad_val = read.table('c2t_edge_mutspec.tsv', header = T)
names(grad_val) = c('RefNode', 'label', 'MutSpec')


test = full_join(as_tibble(bog_tree), tibble(grad_val[,c(2,3)]), by = 'label')

#fit <- phytools::fastAnc(bog_tree, test, vars=TRUE, CI=TRUE)

der = as.treedata(test)

svglite::svglite("Cov_Tree.svg", width = 20, height = 20)
ggtree(der, aes(color = der@data$MutSpec)) + geom_tiplab(size = 4)+
  scale_color_continuous(low="green", high="red") +
  theme(legend.position="right")+
  labs(col="MutSpec")

dev.off()
