#load the training and test data into frames
data_x_train <- read.table("./X_train.txt")
data_x_test <- read.table("./X_test.txt")

#load the feature labels
labels <-read.table("./features.txt")

#load the associated test and training subject ids
data_id_train <- read.table("./y_train.txt")
data_id_test <-read.table("./y_test.txt")

#merge the test and trainign data and identifiers
data_id<-rbind(data_id_train,data_id_test)
data_x<-rbind(data_x_train,data_x_test)

#label the data appropriately
idn<-c("id")
colnames(data_x)=labels[,2]
colnames(data_id)<-idn

#link the identifiers with the data, 
data_all<-cbind(data_id,data_x)

#compute the means and deviations. 
#Can uncomment the prints to print the values.
sample_mean<-apply(data_x,2,mean)
sample_sdev<-apply(data_x,2,sd)
#print(sample_mean)
#print(sample_sdev)

#now compute the average of each variable for each activity and subject.
#This is the set desired for step 5
df=data.frame(matrix(ncol=561,nrow=6))
colnames(df)=colnames(data_all)[2:562]
for(i in 2:562){
      df[,i-1]=tapply(data_all[,i],data_all$id,mean)
}


write.table(df, file="averages.txt",row.names=FALSE,col.names=TRUE)
