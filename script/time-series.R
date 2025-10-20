#N Malusi
#Time-Series Data Project

rm(list=ls()) 
#a Open the timeseries data and print 15 observations
install.packages("readxl")
library(readxl)
(data1<-read_excel("C:/Users/nomak/OneDrive/CERTIFICATES/ForecastData/timeseries.xlsx"))

(data1<-data.frame(data1))
attach(data1)
head(data1,15)

#b Determine by using plots if the series is stationary. if not, difference until stationary
library(tseries)

library(forecast)
tsdisplay(timeseries)


#Considering the time series plot, the series appears to be stationary.
#The repeating seasonal pattern seems to have been stabilized, suggesting stationarity.
#Shows a sharp drop after lag 1, with most values within the significance bounds. 
#Displays a significant spike at lag 1, then quickly drops off—another indicator of stationarity.

#c Using function auto.arima() determine optimal order of ARIMA
model<-auto.arima(load_forecast)
model
summary(load_forecast)
#The model is ARIMA(5,0,2)

#d Determine whether the series follows a white noise process
acf(load_forecast, main = "ACF of Load Forecast")
pacf(load_forecast, main = "ACF of Load Forecast")
#The series does not follow the White Noise process.
#ACF Plot: Shows a significant spike at lag 1 and few more lags outside the confidence bounds. 
#--In a white noise process, all autocorrelations should be close to zero and within the bounds. 
#--This indicates autocorrelation is present, which violates white noise assumptions.
#PACF Plot: Also shows a strong spike at lag 1, suggesting partial autocorrelation. White noise should have no significant partial autocorrelations.

#e Considering lags 5, 10, 15, 20, 25 and 30.Test whether the residuals of the specified model are white noise.
#Ho: Series of residuals is white noise 
Box.test(load_forecast,20,type="Ljung")$p.value
for (i in seq(5,30,5))
  print(paste("i =", i, "p-value=", Box.test(load_forecast,i,type="Ljung")$p.value))
#All the p-values in the output are less than alpha=0.05, we reject the null hypothesis. 
#Therefore, according to this test the residual series can not be considered as white noise. 

#f Forecast for the next 24 hours(1day)
forecast_24hours<-forecast(load_forecast,h=30,level=0.95)
forecast_24hours

#Questions based on the data
#i
plot(load_forecast, type = "b", main = "Electricity Load Over Time", ylab = "Load", xlab = "Time")


#ii
summary(load_forecast)
#The average electricity load p/h is 1184.5
#The highest electricity load p/h is 1323.7
#The lowest electricity load p/h is 1006.1






