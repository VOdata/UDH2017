totaal = read_feather('db/neuraalnet/totaal_1.fe')

labels = read_feather('db/neuraalnet/totaal_labels.fe')

labels = labels[,-1]


samp = sample(nrow(totaal),  round(0.8*  nrow(totaal)     )    )



train = totaal[samp,]
train_labels =  train_labels[samp,]


test = totaal[-samp,]
test_labels =  train_labels[-samp,]


write_feather(train, 'db/neuraalnet/train.fe')

write_feather(train_labels, 'db/neuraalnet/train_labels.fe')

write_feather(test, 'db/neuraalnet/test.fe')

write_feather(test_labels, 'db/neuraalnet/test_labels.fe')





