######### ANÁLISE DE SENTIMENTOS #########

#### Pacotes necessários ####
#install.packages("syuzhet")
#install.packages("tidyverse")
#install.packages("readr")
library(syuzhet)
library(tidyverse)
library(readr)

#### Importando os dados ####
url <- "https://raw.githubusercontent.com/lincolnsotto/analise_de_sentimentos/5dbf60427c107a70a5561748d31ea9ebc8e3295d/texto_feliz.txt"
name <- "texto_feliz.txt"
df <- utils::download.file(url,name)
df <- readr::read_file("texto_feliz.txt")


#### Criando os tokens ####
texto_palavras <- get_tokens(df)
sentimentos_df <- get_nrc_sentiment(texto_palavras, lang="portuguese")

## Renomeando as colunas
colnames(sentimentos_df) <- c("Raiva", "Ansiedade", "Desgosto", "Medo", "Alegria", "Tristeza", "Surpresa", "Confiança", 
                              "Negativo", "Positivo")

## Gerando gráfico com os sentimentos
barplot( 
  colSums(prop.table(sentimentos_df[, 9:10])),
  space = 0.2,
  horiz = FALSE,
  las = 1,
  cex.names = 0.7,
  col = brewer.pal(n = 8, name = "Set3"),
  main = "Sentimento relacionado ao contexto",
  sub = "Texto by ChatGPT")

## Gerando gráfico com as emoções
barplot(
  colSums(prop.table(sentimentos_df[, 1:8])),
  space = 0.2,
  horiz = FALSE,
  las = 1,
  cex.names = 0.7,
  col = brewer.pal(n = 8, name = "Set3"),
  main = "Emoções relacionada ao contexto",
  sub = "Texto by ChatGPT")

