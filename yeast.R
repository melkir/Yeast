# Chargement de la librairie
library(FactoMineR)
library(cluster)

# Chargement des donnees
yeast<-read.table("data/yeast.data")
# Ajout des attributs sur la premiere ligne
colnames(yeast) <- c("Sequence Name", "mcg", "gvh", "alm", "mit", "erl", "pox", "vac", "nuc", "C.D.")

# Application d'une PCA
pca.yeast=PCA(yeast[,seq(2,ncol(yeast))], quali.sup=c(9), quanti.sup=c(5,6), graph=FALSE)
par(mfrow=c(1,2))
plot(pca.yeast, choix="ind", habillage=9)
plot(pca.yeast, choix="var")
title("PCA_Référence", outer=TRUE)


# Agglomerative Nesting (Hierarchical Clustering)
cah.yeast=agnes(yeast, method="ward", stand=TRUE)
classes = cutree(cah.yeast, 4)
yeast.classes=cbind.data.frame(yeast, as.factor(classes))
pca.res = PCA(yeast.classes[,2:11], quali.sup= c(5,6,9,10), graph=FALSE)
# Graph
dev.new()
par(mfrow=c(1,1))
plot(pca.res, choix="ind", habillage=10)
title ("CAH", outer=TRUE)

# Classification Hiérarchique sur Composantes principales
#HCPC(pca.yeast)

# K-means
dnorm=scale(yeast[,2:9])
kmeans.yeast=kmeans(dnorm, 4)
yeast.classes=cbind.data.frame(yeast, as.factor(kmeans.yeast$cluster))
pca.res = PCA(yeast.classes[,2:11], quali.sup= c(5,6,9,10), graph=FALSE)
dev.new()
plot(pca.res, choix="ind", habillage=10)
title ("K-Means", outer=TRUE)
