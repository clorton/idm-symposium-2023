# implement an SIR model given an initial susceptible population,
# the infection rate, the recovery rate, and the number of days
# to run the model
sir <- function(s0, i0, r0, beta, gamma, days) {
  # initialize the vectors
  s <- numeric(days)
  i <- numeric(days)
  r <- numeric(days)
  # set the initial values
  s[1] <- s0
  i[1] <- i0
  r[1] <- r0
  # run the model
  for (t in 2:days) {
    s[t] <- s[t-1] - beta * s[t-1] * i[t-1]
    i[t] <- i[t-1] + beta * s[t-1] * i[t-1] - gamma * i[t-1]
    r[t] <- r[t-1] + gamma * i[t-1]
  }
  # return the results
  return(list(s=s, i=i, r=r))
}

# write a function to plot the results
plot_sir <- function(sir, title) {
  # plot the results
  plot(sir$s, type="l", col="blue", ylim=c(0,1), xlab="Days", ylab="Fraction of Population", main=title)
  lines(sir$i, col="red")
  lines(sir$r, col="green")
  legend("topright", c("Susceptible", "Infected", "Recovered"), col=c("blue", "red", "green"), lty=1)
  # save the plot to a .png file
    png(paste(title, ".png", sep=""))
}

# run the model for 150 days with infection rate of 2.5/6/1000, recovery rate of 1/6 and an initial population of 1000
sir1 <- sir(1000, 1, 0, 2.5/6/1000, 1/6, 150)
plot_sir(sir1, "SIR Model with R0=2.5")
