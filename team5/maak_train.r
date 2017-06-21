
#lees filenames en bepaal het aantal
files = list.files('db/raster_plaatjes')


files_list = split(files, 1:1)

#maak directory
if(! dir.exists('db/neuraalnet')){
  dir.create('db/neuraalnet')
}



w = 100
h= 100
c=3


##########maak cluster aan
no_cores <- detectCores() - 4
cl <- makeCluster(no_cores)

clusterCall(cl, function() { 
  library(feather)
  library(EBImage)
})

clusterExport(cl=cl, list("w", "h", "c"),
              envir=environment())

#######



sapply( c(1:length(files_list)) , function(n){
  
  files = files_list[[n]]
  
  
  df = parLapply(cl,  files, function(file){
    
    a = array(dim = c(w,h,c))
    
    
    
    
    #lees fotos in
    im = readImage(paste0('db/raster_plaatjes/',file))
    
    
    
    #resize
    im = resize(im, w = w, h = h)
    
    
    
    
    
    
    
    
    a[,,1] = imageData(im[,,1])
    a[,,2] = imageData(im[,,2])
    a[,,3] = imageData(im[,,3])
    
    
    
    
    
    a = aperm(a, c(3,2,1))
    
    
    extra = matrix( a , ncol =1)
    
    #normaliseer df[N,,,]
    ma = max(extra)
    mi = min(extra)
    
    extra<- scale( extra,center = mi , scale = ma-mi)
    
    extra = matrix(extra, nrow = 1)
    return(extra)
    
    
    
    
  })
  
  
  
  df = as.data.frame(t(matrix(unlist(df), ncol = length(df)  )))
  
  
  
  write_feather(df, path = paste0('db/neuraalnet/totaal_', n, '.fe'))
  
  
})


stopCluster(cl)











