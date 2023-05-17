#! /usr/bin/env python3

"""SEIR Model with Numpy"""

# import the NumPy library
import numpy as np

# define a function to simulate an SEIR model
# given a starting population, infectious rate, recovery rate,
# and number of days to simulate
# return the number of susceptible, exposed, infected, and recovered
# individuals for each day
# use Numpy arrays to store the results
def seir_model(population, infectious_rate, incubation_rate, recovery_rate, days):
    # create arrays to store the results
    susceptible = np.zeros(days)
    exposed = np.zeros(days)
    infected = np.zeros(days)
    recovered = np.zeros(days)

    # set the initial values
    susceptible[0] = population - 1
    exposed[0] = 1
    infected[0] = 0
    recovered[0] = 0

    # run the simulation
    for day in range(1, days):
        susceptible[day] = susceptible[day - 1] - infectious_rate * susceptible[day - 1] * infected[day - 1]
        exposed[day] = exposed[day - 1] + infectious_rate * susceptible[day - 1] * infected[day - 1] - incubation_rate * exposed[day - 1]
        infected[day] = infected[day - 1] + incubation_rate * exposed[day - 1] - recovery_rate * infected[day - 1]
        recovered[day] = recovered[day - 1] + recovery_rate * infected[day - 1]

    # return the results
    return susceptible, exposed, infected, recovered

# define a function to run the SEIR model and plot the results with Matplotlib, saving the results to a .PNG file
def seir_plot(population, infectious_rate, incubation_rate, recovery_rate, days, filename):
    # import the Matplotlib library
    import matplotlib.pyplot as plt

    # run the simulation
    susceptible, exposed, infected, recovered = seir_model(population, infectious_rate, incubation_rate, recovery_rate, days)

    # create a figure
    plt.figure()

    # plot the results
    plt.plot(susceptible, label = "Susceptible")
    plt.plot(exposed, label = "Exposed")
    plt.plot(infected, label = "Infected")
    plt.plot(recovered, label = "Recovered")

    # add a title and axes labels
    plt.title("SEIR Model")
    plt.xlabel("Days")
    plt.ylabel("Individuals")

    # add a legend
    plt.legend()

    # save the figure to a file
    plt.savefig(filename)

# define a main function
def main():
    # set the parameters
    population = 1000
    infectious_rate = 2.5/6.0/population  # 2.5 people infected per day per person, 6 days to infect
    incubation_rate = 1.0/4.0   # 4 days to incubate
    recovery_rate = 1.0/6.0     # 6 days to recover
    days = 150

    # run the simulation and plot the results
    seir_plot(population, infectious_rate, incubation_rate, recovery_rate, days, "seir.png")

# call the main function
if __name__ == "__main__":
    main()
