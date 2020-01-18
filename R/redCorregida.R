# Libraryas
library(tidyverse)
library(networkD3)

niveles <- function(x) levels(as.factor(x))

edges <- read_csv("DatosMitchell/gen_edgelist.csv")
nodes <- read_csv("DatosMitchell/gen_node_atts.csv")

enlaces <- edges  %>% head(n = 100) %>% 
  select(-X1)

nodos <- nodes %>% 
  filter(nodes %in% niveles(c(enlaces$source, enlaces$target)))

nodos$X1 <- 0:(dim(nodos)[1]-1)


for (j in 1:dim(nodos)[1]){
    for (i in 1:dim(enlaces)[1]){
      
      if(enlaces$source[i] == nodos$nodes[j]){
        enlaces$source[i] <- nodos$X1[j]
      }
      
      if(enlaces$target[i] == nodos$nodes[j]){
        enlaces$target[i] <- nodos$X1[j]
      }
      
    }
}

enlaces <- enlaces %>% as.data.frame()
nodos <- nodos %>% as.data.frame()


forceNetwork(Links = enlaces, 
             Nodes = nodos, 
             Source = "source", 
             Target = "target", 
             Value = "weight",
             NodeID = "nodes", 
             Group = "community",
             Nodesize = "community", 
             zoom = T, 
             opacity = 1, 
             bounded = FALSE
             )

# 
# MyClickScript <- 'alert("You clicked " + d.name + " which is in row " +
#        (d.index + 1) +  " of your original R data frame");'
# 
# forceNetwork(Links = MisLinks, Nodes = MisNodes, Source = "source",
#              Target = "target", Value = "value", NodeID = "name",
#              Group = "group", opacity = 1, zoom = FALSE,
#              bounded = TRUE, clickAction = MyClickScript)
# 
# 
# data("MisLinks")
# data("MisNodes")
# 
# 
# MisLinks %>% head()
# MisNodes %>% head()
