######### ANÁLISE DE SENTIMENTOS #########

#### Pacotes necessários ####
#install.packages("syuzhet")
#install.packages("RColorBrewer")
#install.packages("tidyverse")
#install.packages("readr")
library(syuzhet)
library(RColorBrewer)
library(tidyverse)
library(readr)

#### Importando os dados ####
url <- "https://raw.githubusercontent.com/lincolnsotto/analise_de_sentimentos/5dbf60427c107a70a5561748d31ea9ebc8e3295d/texto_feliz.txt"
name <- "texto_feliz.txt"
df <- download.file(url,name)
df <- read_file("texto_feliz.txt")


#### Criando os tokens ####
texto_palavras <- get_tokens(df)
sentimentos_df <- get_nrc_sentiment(texto_palavras, lang="portuguese")
head(sentimentos_df)
summary(sentimentos_df)

## Juntando os vetores classificados com as palavras originais
sentimentos_df2 <- cbind(texto_palavras, sentimentos_df)
writexl::write_xlsx(sentimentos_df2, "sentimentos_words.xlsx")

## Renomeando as colunas
colnames(sentimentos_df) <- c("Raiva", "Ansiedade", "Desgosto", "Medo", "Alegria", "Tristeza", "Surpresa", "Confiança", "Negativo", "Positivo")

barplot(
  colSums(prop.table(sentimentos_df[, 9:10])),
  space = 0.2,
  horiz = FALSE,
  las = 1,
  cex.names = 0.7,
  col = brewer.pal(n = 8, name = "Set3"),
  main = "Sentimento relacionado
  Ao uso do celular corporativo",
  #sub = "Análise realizada por Diana Rebelo Rodriguez",
  xlab="emoções", ylab = NULL)

barplot(
  colSums(prop.table(sentimentos_df[, 1:8])),
  space = 0.2,
  horiz = FALSE,
  las = 1,
  cex.names = 0.7,
  col = brewer.pal(n = 8, name = "Set3"),
  main = "Emoções relacionadas
  Ao uso do celular corporativo",
  #sub = "Análise realizada por Diana Rebelo Rodriguez",
  xlab="emoções", ylab = NULL)


