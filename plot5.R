# The script works when the extracted data is in your working directory
# It also uses the ggplot2 and reshape2 packages

library(reshape2)
directory <- getwd()
NEI <- readRDS(paste(directory,"summarySCC_PM25.rds",sep="/"))
SCC <- readRDS(paste(directory,"Source_Classification_Code.rds",sep="/"))
Baltimore <- subset(NEI,fips=="24510")
newBaltimore <- merge(Baltimore,SCC,by.x="SCC",by.y="SCC")
newBaltimore1 <- newBaltimore[newBaltimore$type=="ON-ROAD",]
newBaltimore2 <- as.data.frame(tapply(newBaltimore1$Emissions,newBaltimore1$year,sum))
names(newBaltimore2) <- make.names("ToTal Emissions")
newBaltimore2$ToTal.Emissions <- as.numeric(newBaltimore2$ToTal.Emissions)
newBaltimore2$Year <- rownames(newBaltimore2)
rownames(newBaltimore2) <- 1:4
png(file="plot5.png",bg="transparent")
with(newBaltimore2,plot(Year,ToTal.Emissions,col="tan4",pch=19,main="On-Road Sources' Total Emissions in Baltimore City",font.main=2,col.main="springgreen3",col.lab="springgreen3",ylab="Total Emissions",font.lab=2,type="o",lty=3))
text(newBaltimore2$Year,newBaltimore2$ToTal.Emissions,labels=round(newBaltimore2$ToTal.Emissions,digits=2),col="tan4",cex=0.75,pos=c(4,1,1,2))
title(sub="(1999,2002,2005,2008)",cex.sub=0.8,col.sub="thistle4")
dev.off()

