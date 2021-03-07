# CMEE 2020 HPC excercises R code challenge G proforma

rm(list=ls()) # nothing written elsewhere should be needed to make this work

# please edit these data to show your information.
name <- "Jingkai Sun"
preferred_name <- "Kyle"
email <- "jingkai.sun20@imperial.ac.uk"
username <- "ks3020"

# don't worry about comments for this challenge - the number of characters used will be counted starting from here
f<-function(s=c(5,5),d=pi/2,l=1,i=1){e<-c(s[1]+l*cos(d),s[2]+l*sin(d));lines(c(s[1],e[1]),c(s[2],e[2]),type="l");if(l>=0.01){f(e,d,0.87*l,-i);f(e,d+i*pi/4,0.38*l,i)}};plot(1,xlab='',ylab='',xlim=c(2.5,7),ylim=c(4.5,13));f()