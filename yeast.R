# Chargement de la librairie
library(FactoMineR)

# Chargement des donnees
yeast<-read.table("data/yeast.data")
# Ajout des attributs sur la premiere ligne
colnames(yeast) <- c("Sequence Name", "mcg", "gvh", "alm", "mit", "erl", "pox", "vac", "nuc", "C.D.")
# Application d'une PCA
pca.yeast=PCA(yeast, quali.sup=c(1,10))
