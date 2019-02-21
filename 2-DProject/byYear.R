dat<-read.csv("combined_fin.csv",head=T,col.names=c("Year", "itemtype","Count"))

aat <- dat[dat$itemtype == "accas",c("Year","Count")]
acbk <- dat[dat$itemtype == "acbk",c("Year","Count")]
acdvd <- dat[dat$itemtype == "acdvd",c("Year","Count")]
acvhs <- dat[dat$itemtype == "acvhs",c("Year","Count")]
accdrom <- dat[dat$itemtype == "accdrom",c("Year","Count")]
acper <- dat[dat$itemtype == "acper",c("Year","Count")]

par(mfrow=c(2,3))
plot(Count~Year, aat,main="Adult Audiotape Use", xlab="Year",ylab="Number of Checkouts",pch=19,cex=1.5,col="royalblue1")
plot(Count~Year, acbk,main="Adult Book Use", xlab="Year",ylab="Number of Checkouts",pch=19,cex=1.5,col="orangered1")
plot(Count~Year, acdvd,main="Adult DVD Use", xlab="Year",ylab="Number of Checkouts",pch=19,cex=1.5,col="green4")
plot(Count~Year, acvhs,main="Adult VHS Use", xlab="Year",ylab="Number of Checkouts",pch=19,cex=1.5,col="gray20")
plot(Count~Year, accdrom,main="Adult CD-ROM Use", xlab="Year",ylab="Number of Checkouts",pch=19,cex=1.5,col="violetred3")
plot(Count~Year, acper,main="Adult Magazine Use", xlab="Year",ylab="Number of Checkouts",pch=19,cex=1.5,col="burlywood4")

acbk2009<-read.csv("acbk2009.csv",head=T,col.names=c("Month", "Count"))
acdvd2009<-read.csv("acdvd2009.csv",head=T,col.names=c("Month", "Count"))
par(mfrow=c(1,2))
plot(Count~Month, acbk2009,main="Adult Books in 2009", xlab="Month",ylab="Number of Checkouts",pch=19,cex=1.5,col="royalblue1")
plot(Count~Month, acdvd2009,main="Adult DVDs in 2009", xlab="Month",ylab="Number of Checkouts",pch=19,cex=1.5,col="orangered1")
