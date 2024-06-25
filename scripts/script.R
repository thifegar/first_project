rm(list = ls())
source("functions.R")

if (!require("ggplot2")) install.packages("ggplot2")
if (!require("stringr")) install.packages("stringr")
if (!require("tidyverse")) install.packages("tidyverse")

library(tidyverse)
library(forcats)

# j'importe les données avec read_csv2 parce que c'est un csv avec des ; et que read_csv attend comme separateur des ,
df <- arrow::read_parquet("data/individu_reg.parquet")

df <- df %>% select(region, aemm ,  aged ,  anai ,  catl ,  cs1 ,  cs2 ,  cs3 ,  couple ,  na38 ,  naf08 ,  pnai12 ,  sexe ,  surf ,  tp ,  trans ,  ur ))

df <- df %>%
  mutate(aged = as.numeric(aged))
df_plot <- df %>%
  group_by(aged) %>% 
  summarise(n())

ggplot(df_plot, aes(x = 5*floor(as.numeric(aged)/5))) + geom_histogram(stat="bin")

# stats trans par statut
df3 <-  df %>% 
  group_by(couple, trans) %>% 
  summarise(x = n()) %>% 
  group_by(couple) %>% 
  mutate(y = 100*x/sum(x))

# part d'homme dans chaque cohort
p <- df %>% 
  group_by(aged, sexe) %>% 
  summarise(SH_sexe = n()) %>% 
  group_by(aged) %>% 
  mutate(SH_sexe = SH_sexe / sum(SH_sexe)) %>% 
  filter(sexe==1) %>%
  ggplot() + geom_bar(aes(x = aged, y = SH_sexe), stat="identity") + geom_point(aes(x = aged, y = SH_sexe), stat="identity", color = "red") + coord_cartesian(c(0,100))

ggsave("p.png", p)


df <- fct_recode_sexe(df)


#fonction de stat agregee
calcule_une_statistique(rnorm(10))
calcule_une_statistique(rnorm(10), "ecart-type")
calcule_une_statistique(rnorm(10), "variance")

calcule_une_statistique(df %>% filter(sexe == "Homme") %>% pull(aged))
calcule_une_statistique(df %>% filter(sexe == "Femme") %>% pull(aged))

api_token <- "trotskitueleski$1917"

# modelisation
df3 <- df %>%
  select(surf, cs1, ur, couple, aged)%>%
  filter(surf!="Z")

df3[,1] <- factor(df3$surf, ordered = T)
df3[,"cs1"] <- factor(df3$cs1)
df3 %>% 
  filter(couple == "2" 
         & aged>40 
         & aged<60)
# res_polr <- MASS::polr(surf ~ cs1 + factor(ur), df3)
# res_polr
# summary(res_polr, digits = 3)




