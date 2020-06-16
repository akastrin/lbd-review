source('requirements.R')
library(bibliometrix)

## Data loading
data <- readRDS(file = './data/data.rds')

## Bibliometric analysis
res <- biblioAnalysis(data, sep = ';')
S <- summary(res, k = 10, pause = FALSE)

## Most frequent cited manuscripts
cr_ar <- citations(data, field = 'article', sep = ';')
cbind(cr_ar$Cited[1:10])

## Most frequent cited first authors
cr_au <- citations(data, field = 'author', sep = ';')
cbind(cr_au$Cited[1:10])

## Most frequent local cited authors
cr_loc <- localCitations(data, sep = ';')
cr_loc$Authors[1:10,]
cr_loc$Papers[1:10,]

## Authors' Dominance ranking
dom <- dominance(res, k = 10)
dom

## Authors' h-index
ind <- Hindex(data, field = 'author', elements = 'SWANSON DR',
              sep = ';', years = 10)
ind$H
ind$CitationList

## h-index of the first 10 most productive authors
auth <- gsub(',', ' ', names(res$Authors)[1:10])
ind <- Hindex(data, field = 'author', elements = auth, sep = ';',
              years = 50)
ind$H

## Top-Authors' Productivity over the Time
top_au <- authorProdOverTime(data, k = 10, graph = TRUE)
head(top_au$dfAU)

## Lotka's Law coefficient
lotka <- lotka(res)
lotka$AuthorProd

## Some basic plots
plot(res, k = 10, pause = FALSE)

## Bibliographic network matrices
net_mat <- biblioNetwork(data, analysis = 'co-citation',
                         network = 'references', sep = ".  ")

## Visualizing bibliographic networks

## Country scientific collaboration
data_co <- metaTagExtraction(data, Field = 'AU_CO', sep = ';')
net_mat_co <- biblioNetwork(data_co, analysis = 'collaboration',
                            network = 'countries', sep = ';')
net_co <- networkPlot(net_mat_co, n = dim(net_mat_co)[1],
                      Title = 'Country Collaboration', type = 'circle',
                      size = TRUE, remove.multiple = FALSE, labelsize = 0.8)
networkStat(net_co)

## Co-citation network
net_mat_cc <- biblioNetwork(data, analysis = 'co-citation',
                            network = 'references', sep = '.  ')
net_cc <- networkPlot(net_mat_cc, n = 30, Title = 'Co-Citation Network',
                type = 'fruchterman', size = TRUE, remove.multiple = FALSE,
                labelsize = 0.7, edgesize = 5)
networkStat(net_cc)

## Keyword co-occurrence network
net_mat_kw <- biblioNetwork(M, analysis = 'co-occurrences',
                            network = 'keywords', sep = ";")
net_kw <- networkPlot(net_mat_kw, normalize = 'association', weighted = TRUE,
                      n = 30, Title = 'Keyword Co-occurrences',
                      type = 'fruchterman', size = TRUE, edgesize = 5,
                      labelsize = 0.7)
networkStat(net_kw)

## Conceptual structure (CA)
cs <- conceptualStructure(data, field = 'ID', method = 'CA', minDegree = 4,
                          k.max = 8, stemming = FALSE, labelsize = 10,
                          documents = 10)

## Historical citation network
his_res <- histNetwork(data, sep = ".  ")
net_his <- histPlot(his_res, n = 20, size = FALSE, label = TRUE,
                    arrowsize = 0.5)

## Bibliographic coupling
net_mat_cpl <- biblioNetwork(data, analysis = 'coupling',
                             network = 'references', sep = '.  ')
net_mat_cpl <- biblioNetwork(data, analysis = "coupling",
                             network = 'authors', sep = ';')
net_cpl <- networkPlot(net_mat_cpl, normalize = 'salton', weighted = NULL,
                       n = 100, Title = 'Authors Coupling', type = 'fruchterman',
                       size = 5, size.cex = TRUE, remove.multiple = TRUE,
                       labelsize = 0.8, label.n = 10, label.cex = FALSE)
