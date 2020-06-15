## source('requirements.R')
library(bibliometrix)

## Data loading
data <- readRDS(file = './data/data.rds')

## Bibliometric analysis
res <- biblioAnalysis(data, sep = ';')
S <- summary(res, k = 10, pause = FALSE)

## Some basic plots
plot(res, k = 10, pause = FALSE)

## Bibliographic network matrices
net_mat <- biblioNetwork(data, analysis = 'co-citation', network = "references", sep = ".  ")

## Visualizing bibliographic networks

## Country scientific collaboration
data_co <- metaTagExtraction(data, Field = 'AU_CO', sep = ';')
net_mat_co <- biblioNetwork(data_co, analysis = 'collaboration', network = 'countries', sep = ';')

## Plot the network
net_co <- networkPlot(net_mat_co, n = dim(net_mat_co)[1], Title = 'Country Collaboration', type = 'circle', size = TRUE, remove.multiple = FALSE, labelsize = 0.8)
