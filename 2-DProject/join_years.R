d2016<-read.csv("2016.csv",head=T,col.names=c("itemtype","2016"))
d2014<-read.csv("2014.csv",head=T,col.names=c("itemtype","2014"))
d2013<-read.csv("2013.csv",head=T,col.names=c("itemtype","2013"))
d2011<-read.csv("2011.csv",head=T,col.names=c("itemtype","2011"))

dcomb<-merge(d2016,d2014,by=toString('itemtype'),all.x=T)
dcomb<-merge(dcomb,d2013,by=toString('itemtype'),all.x=T)
dcomb<-merge(dcomb,d2011,by=toString('itemtype'),all.x=T)
write.csv(dcomb,"combined.csv")

library(ggplot2)
adult_audiotape <- dcomb[dcomb$itemtype == "accas", c("X2016", "X2014", "X2013","X2011")]
aat <- data.frame(Value = unlist(adult_audiotape), Year = factor(1:4))
adult_book <- dcomb[dcomb$itemtype == "acbk", c("X2016", "X2014", "X2013","X2011")]
acbk <- data.frame(Value = unlist(adult_book), Year = factor(1:4))
adult_dvd <- dcomb[dcomb$itemtype == "acdvd", c("X2016", "X2014", "X2013","X2011")]
acdvd <- data.frame(Value = unlist(adult_dvd), Year = factor(1:4))
adult_vhs <- dcomb[dcomb$itemtype == "acvhs", c("X2016", "X2014", "X2013","X2011")]
acvhs <- data.frame(Value = unlist(adult_vhs), Year = factor(1:4))

library(ggplot2)
library(cowplot)

par(mfrow=c(2,2))
ggplot() + geom_line(aes(y = Value, x = Year), size=1.5, group=1, 
                           data = aat, stat="identity") + labs(x="Year", y="Number of Check-outs") +
  ggtitle("Adult Audiotape Use")
ggplot() + geom_line(aes(y = Value, x = Year), size=1.5, group=1, 
                     data = acbk, stat="identity") + labs(x="Year", y="Number of Check-outs") +
  ggtitle("Adult Book Use")
ggplot() + geom_line(aes(y = Value, x = Year), size=1.5, group=1, 
                     data = acdvd, stat="identity") + labs(x="Year", y="Number of Check-outs") +
  ggtitle("Adult DVD Use")
ggplot() + geom_line(aes(y = Value, x = Year), size=1.5, group=1, 
                     data = acvhs, stat="identity") + labs(x="Year", y="Number of Check-outs") +
  ggtitle("Adult VHS Use")
plot_grid(aat, acbk,acdvd, acvhs, labels = "AUTO")



plot(Value ~ Year, aat, title="Audio Tape Use")
plot(Value ~ Year, acbk, title="Book Use")
plot(Value ~ Year, acdvd, title="DVD Use")
plot(Value ~ Year, acvhs, title="VHS Use")


library(reshape)
mdata <- melt(dcomb, id=c("itemtype"))
write.csv(mdata,"combined2.csv")
