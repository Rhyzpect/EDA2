# The script works when the extracted data is in your working directory
library(dplyr)
library(ggplot2)
directory <- getwd()
NEI <- readRDS(paste(directory,"summarySCC_PM25.rds",sep="/"))
SCC <- readRDS(paste(directory,"Source_Classification_Code.rds",sep="/"))

# I get an error when I merge SCC and NEI directly because the data are big. So I have to do it in the long way
coal <- grep("Coal",SCC$EI.Sector)
coalSCC <- newSCC[coal,"SCC"]
coalSCC <- as.matrix(coalSCC)
CoalNEI <- merge(coalSCC,NEI,by.x="V1",by.y="SCC")
png(file="plot4.png",width=600,bg="transparent")
US <- ggplot(aes(year,Emissions),data=CoalNEI)+stat_summary(fun.y=sum,geom="point",color="red",cex=3)
US+stat_summary(fun.y=sum,geom="line",lty=4,color="red")+ggtitle("TOTAL EMISSIONS FROM COAL COMBUSTION RELATED SOURCES IN THE US")+theme_light()
dev.off()