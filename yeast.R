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

# Agglomerative Nesting (Hierarchical Clustering)
cah.yeast=agnes(yeast, method="ward", stand=TRUE)

classes = cutree(cah.yeast, 10)
yeast.classes=cbind.data.frame(yeast, as.factor(classes))
res.pca = PCA(yeast.classes[,2:11], quali.sup= c(1,10,11), graph=FALSE)
plot(res.pca, choix="ind", habillage=10)
# Classification Hiérarchique sur Composantes principales
#HCPC(pca.yeast)
