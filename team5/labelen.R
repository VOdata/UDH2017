#k = 10

#totaal = read_feather(paste0('db/neuraalnet/totaal_', k, '.fe'))


totaal = read_feather(paste0('db/neuraalnet/totaal_1.fe'))
totaal = as.matrix(totaal)
totaal_labels = c()


for(i in 1:nrow(totaal)){

  im = array( as.vector(totaal[i,]) , dim = c(3,100,100))
  im = aperm(im, c(1,3,2))
  im[2,,] = im[2,c(100:1),c(100:1)]
  image( as.matrix(im[2, ,]))
  
  totaal_labels[i] = readline(prompt="goed =1 fout = 2?: ")


}


labels = data.frame()

for(i in 1:length(totaal_labels)){
  if(totaal_labels[i] == 1){
    labels = rbind(labels, c(i,1,0))
  }
  
  if(totaal_labels[i] == 2){
    labels = rbind(labels, c(i,0,1))
  }
  
  
}


write_feather(labels, path = paste0('db/neuraalnet/totaal_labels.fe'))

