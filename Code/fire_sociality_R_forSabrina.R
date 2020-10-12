
####setwd####
setwd("C:/Users/Samantha/Dropbox/Lantz thesis chapters/short-term fire response/data and R code/social networks/R")
rm(list=ls())

####2013####
obs2013<-read.csv("2013 groups.csv", header=TRUE)
str(obs2013)

install.packages("reshape2")
library(reshape2)

birds2013 = data.frame(obs2013$Group, obs2013$SP, obs2013$Fire,
                   obs2013[grep("Bird",colnames(obs2013))])

#Make a new row for each bird combo
birdmelt = melt(birds2013, id.vars= 1:3)
head(birdmelt)

#get rid of zeros
birdmelt<-birdmelt[!(birdmelt$value == ""), ]
head(birdmelt)
str(birdmelt)
#groups
individuals<-data.frame((as.character(birdmelt$value)), birdmelt$obs2013.Group, birdmelt$obs2013.SP, birdmelt$obs2013.Fire)
head(individuals)
#change names so that they are easier to deal with
colnames(individuals) <- c("ID","Group","SP", "Fire")
head(individuals)
####this gives us a list of each individual and the groups it is associated with, as well as the sampling period
#subset individuals by affected/not and pre/post fire
prefire<-subset(individuals, SP=="Pre")
prefire.affected<-subset(prefire, Fire=="Y")
prefire.notaffected<-subset(prefire, Fire=="N")
postfire<-subset(individuals, SP=="Post")
postfire.affected<-subset(postfire, Fire=="Y")
postfire.notaffected<-subset(postfire, Fire=="N")
affected<-subset(individuals, Fire=="Y")
notaffected<-subset(individuals, Fire=="N")

####asnipe####
#install.packages("asnipe")
library(asnipe)

#network.RBW<-get_network(gbi.RBW, data_format="GBI")
#str(network.RBW)
#head(network.RBW)
#network.RBW<-network.RBW[order(rownames(network.RBW)), order(colnames(network.RBW))]
#network.RBW
#subsetting by pre/post/affected/notaffected

######prefire####

#pre.gbi <- get_group_by_individual(prefire, 
#                               data_format="individuals")
#head(pre.gbi)
#str(pre.gbi)

#pre.network<-get_network(pre.gbi, data_format="GBI")
#pre.network<-pre.network[order(rownames(pre.network)), order(colnames(pre.network))]
#the above command puts the network in alphabetical order so that it matches up with the attributes (which are alphabetical)

#pre.deg_weighted <- degree(pre.network,gmode="graph", g=c(1,2), ignore.eval=FALSE)

####prefire affected####
pre.affected.gbi <- get_group_by_individual(prefire.affected, 
                                   data_format="individuals")

pre.affected.network<-get_network(pre.affected.gbi, data_format="GBI")
pre.affected.network<-pre.affected.network[order(rownames(pre.affected.network)), order(colnames(pre.affected.network))]
#the above command puts the network in alphabetical order so that it matches up with the attributes (which are alphabetical)

#install.packages("sna")
library(sna)#used for command degree

pre.affected.deg_weighted <- degree(pre.affected.network,gmode="graph", g=c(1,2), ignore.eval=FALSE)
pre.affected.deg_weighted


####prefire not affected####
pre.notaffected.gbi <- get_group_by_individual(prefire.notaffected, 
                                            data_format="individuals")


pre.notaffected.network<-get_network(pre.notaffected.gbi, data_format="GBI")
#pre.notaffected.network<-pre.notaffected.network[order(rownames(pre.notaffected.network)), order(colnames(pre.notaffected.network))]
#the above command puts the network in alphabetical order so that it matches up with the attributes (which are alphabetical)
pre.notaffected.deg_weighted <- degree(pre.notaffected.network,gmode="graph", g=c(1,2), ignore.eval=FALSE)
pre.notaffected.deg_weighted

######postfire####
#post.gbi <- get_group_by_individual(postfire, 
 #                                  data_format="individuals")
#head(post.gbi)
#str(post.gbi)

#post.network<-get_network(post.gbi, data_format="GBI")
#post.network<-post.network[order(rownames(post.network)), order(colnames(post.network))]

#post.deg_weighted <- degree(post.network,gmode="graph", g=c(1,2), ignore.eval=FALSE)
#post.deg_weighted

####postfire affected####
post.affected.gbi <- get_group_by_individual(postfire.affected, 
                                            data_format="individuals")

post.affected.network<-get_network(post.affected.gbi, data_format="GBI")
#post.affected.network<-post.affected.network[order(rownames(post.affected.network)), order(colnames(post.affected.network))]
#the above command puts the network in alphabetical order so that it matches up with the attributes (which are alphabetical)

post.affected.deg_weighted <- degree(post.affected.network,gmode="graph", g=c(1,2), ignore.eval=FALSE)
post.affected.deg_weighted
####postfire not affected####
post.notaffected.gbi <- get_group_by_individual(postfire.notaffected, 
                                               data_format="individuals")

post.notaffected.network<-get_network(post.notaffected.gbi, data_format="GBI")
post.notaffected.network<-post.notaffected.network[order(rownames(post.notaffected.network)), order(colnames(post.notaffected.network))]
#the above command puts the network in alphabetical order so that it matches up with the attributes (which are alphabetical)

post.notaffected.deg_weighted <- degree(post.notaffected.network,gmode="graph", g=c(1,2), ignore.eval=FALSE)
post.notaffected.deg_weighted
####affected####

#affected.gbi <- get_group_by_individual(affected, 
 #                                       data_format="individuals")
#head(affected.gbi)
#str(affected.gbi)

#affected.network<-get_network(affected.gbi, data_format="GBI")
#affected.network<-affected.network[order(rownames(affected.network)), order(colnames(affected.network))]
#the above command puts the network in alphabetical order so that it matches up with the attributes (which are alphabetical)

#affected.deg_weighted <- degree(affected.network,gmode="graph", g=c(1,2), ignore.eval=FALSE)
####not affected####
#notaffected.gbi <- get_group_by_individual(notaffected, 
#                                           data_format="individuals")
#head(notaffected.gbi)
#str(notaffected.gbi)

#notaffected.network<-get_network(notaffected.gbi, data_format="GBI")


####2013 summary####
summary(pre.affected.deg_weighted)
str(pre.affected.deg_weighted)
sd(pre.affected.deg_weighted)
summary(post.affected.deg_weighted)
str(post.affected.deg_weighted)
sd(post.affected.deg_weighted)
summary(pre.notaffected.deg_weighted)
str(pre.notaffected.deg_weighted)
sd(pre.notaffected.deg_weighted)
summary(post.notaffected.deg_weighted)
str(post.notaffected.deg_weighted)
sd(post.notaffected.deg_weighted)

####2014####
obs2014<-read.csv("2014 groups.csv", header=TRUE)
str(obs2014)

#####including all birds####
#library(reshape)

birds2014 = data.frame(obs2014$Group, obs2014$SP, 
                       obs2014[grep("Bird",colnames(obs2014))])

#Make a new row for each bird combo
birdmelt = melt(birds2014, id.vars= 1:2)
head(birdmelt)

#get rid of zeros
birdmelt<-birdmelt[!(birdmelt$value == ""), ]
head(birdmelt)
str(birdmelt)
#groups
individuals<-data.frame((as.character(birdmelt$value)), birdmelt$obs2014.Group, birdmelt$obs2014.SP)
head(individuals)
#change names so that they are easier to deal with
colnames(individuals) <- c("ID","Group","SP")
head(individuals)

#
prefire.2014<-subset(individuals, SP=="PRE")
postfire.2014<-subset(individuals, SP=="POST")

####
pre2014.gbi <- get_group_by_individual(prefire.2014, 
                                   data_format="individuals")
#head(pre.gbi)
#str(pre.gbi)

pre2014.network<-get_network(pre2014.gbi, data_format="GBI")
#pre.network<-pre.network[order(rownames(pre.network)), order(colnames(pre.network))]
#the above command puts the network in alphabetical order so that it matches up with the attributes (which are alphabetical)

pre2014.deg_weighted <- degree(pre2014.network,gmode="graph", g=c(1,2), ignore.eval=FALSE)


####
post2014.gbi <- get_group_by_individual(postfire.2014, 
data_format="individuals")
#head(post.gbi)
#str(post.gbi)

post2014.network<-get_network(post2014.gbi, data_format="GBI")
post2014.network<-post2014.network[order(rownames(post2014.network)), order(colnames(post2014.network))]

post2014.deg_weighted <- degree(post2014.network,gmode="graph", g=c(1,2), ignore.eval=FALSE)
post2014.deg_weighted

####
summary(pre2014.deg_weighted)
mean (pre2014.deg_weighted)
str(pre2014.deg_weighted)
sd(pre2014.deg_weighted)
summary(post2014.deg_weighted)
sd(post2014.deg_weighted)
str(post2014.deg_weighted)
#degree is higher post-fire

#####plot social networks#####
library(igraph)
par(mfrow=c(1,1))
pre.aff.net=as.matrix(pre.affected.network)
pre.aff.net
g.pre.aff2013=graph_from_adjacency_matrix(pre.aff.net, mode="undirected", weighted=T)
g.pre.aff2013
plot(g.pre.aff2013, vertex.label="", edge.width=E(g.pre.aff2013)$weight)

pre.notaff.net=as.matrix(pre.notaffected.network)
pre.notaff.net
g.pre.notaff2013=graph_from_adjacency_matrix(pre.notaff.net, mode="undirected", weighted=T)
g.pre.notaff2013
plot(g.pre.notaff2013, vertex.label="", edge.width=E(g.pre.notaff2013)$weight)

post.aff.net=as.matrix(post.affected.network)
post.aff.net
g.post.aff2013=graph_from_adjacency_matrix(post.aff.net, mode="undirected", weighted=T)
g.post.aff2013
plot(g.post.aff2013, vertex.label="", edge.width=E(g.post.aff2013)$weight)

post.notaff.net=as.matrix(post.notaffected.network)
post.notaff.net
g.post.notaff2013=graph_from_adjacency_matrix(post.notaff.net, mode="undirected", weighted=T)
g.post.notaff2013
plot(g.post.notaff2013, vertex.label="", edge.width=E(g.post.notaff2013)$weight)

pre2014.net=as.matrix(pre2014.network)
pre2014.net
g.pre2014=graph_from_adjacency_matrix(pre2014.net, mode="undirected", weighted=T)
g.pre2014
plot(g.pre2014, vertex.label="", edge.width=E(g.pre2014)$weight)

post2014.net=as.matrix(post2014.network)
post2014.net
g.post2014=graph_from_adjacency_matrix(post2014.net, mode="undirected", weighted=T)
g.post2014
plot(g.post2014, vertex.label="", edge.width=E(g.post2014)$weight)

#par(mfrow=c(3,2), mar=c(4.1,4.0,1,1), xpd=NA)

#plot(g.pre.notaff2013, vertex.label="", edge.width=E(g)$weight, vertex.color="black", edge.color="black",ylab="Affected by 2013 fire")#pre 2014 not affected
#plot(g.post.notaff2013, vertex.label="", edge.width=E(g)$weight, vertex.color="black", edge.color="black")#post 2013 not affected
#plot(g.pre.aff2013, vertex.label="", edge.width=E(g)$weight,ylab="Not affected by 2013 fire", vertex.color="black", edge.color="black")#pre2013 affected
#plot(g.post.aff2013, vertex.label="", edge.width=E(g)$weight, vertex.color="black", edge.color="black")#post 2013 affected
#plot(g.pre2014, vertex.label="", edge.width=E(g)$weight, xlab="Pre-fire", ylab="Affected by 2014 fire", vertex.color="black", edge.color="black")#pre 2014
#plot(g.post2014, vertex.label="", edge.width=E(g)$weight, xlab="Post-fire", vertex.color="black", edge.color="black")#post 2014

tiff(file="Fig2.tif",units="in", width=5,height=5,res=300)

par(mfrow=c(3,2), mar=c(1,1.3,0.5,0), xpd=NA)

plot(g.pre.notaff2013, vertex.label="", edge.width=E(g.pre.notaff2013)$weight, vertex.color="black", edge.color="black")
title(ylab="Not affected by 2013 fire", line=0, cex.lab=1.2)
plot(g.post.notaff2013, vertex.label="", edge.width=E(g.post.notaff2013)$weight, vertex.color="black", edge.color="black")#post 2013 not affected
plot(g.pre.aff2013, vertex.label="", edge.width=E(g.pre.aff2013)$weight, vertex.color="black", edge.color="black")#pre2013 affected
title(ylab="Affected by 2013 fire", line=0, cex.lab=1.2)
plot(g.post.aff2013, vertex.label="", edge.width=E(g.post.aff2013)$weight, vertex.color="black", edge.color="black")#post 2013 affected
plot(g.pre2014, vertex.label="", edge.width=E(g.pre2014)$weight, xlab="Pre-fire", vertex.color="black", edge.color="black")#pre 2014
title(ylab="Affected by 2014 fire", xlab="Pre-fire",line=0, cex.lab=1.2)
plot(g.post2014, vertex.label="", edge.width=E(g.post2014)$weight, xlab="Post-fire", vertex.color="black", edge.color="black")#post 2014
title(xlab="Post-fire", line=0, cex.lab=1.2)

dev.off()

