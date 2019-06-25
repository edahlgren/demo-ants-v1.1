# Using an artificial ant colony to find the shortest route

This demo shows how a real ant colony's foraging behavior can be used to search a dataset for the shortest path through connected points. [[1]](http://www.aco-metaheuristic.org/aco-code/public-software.html)

Ants are decentralized and have limited memory and capabilities. Yet through simple communication mechanisms, a colony of ants can efficiently solve complex problems like predator evasion and shortest path finding. If we mimic the behavior of ant colonies in computer systems, we can create efficient, scalable, and distributed algorithms for searching, sorting, and classifying data. [[2]](https://link.springer.com/content/pdf/10.1007%2Fs10994-010-5216-5.pdf)

This demo mimics how ants leave behind a substance called "pheromone" which attracts other ants. Ants that arrive quickly from a food source will leave a double dose of pheromone on the path (there and back). More ants follow, which reinforces the path, and eventually the fastest path is the only one taken by the other ants in the colony. [[3]](https://link.springer.com/content/pdf/10.1007%2Fs11721-016-0130-5.pdf)

In this demo, you can experiment with a simulated ant colony to find solutions to the traveling salesman problem. Solving the traveling salesman problem means finding the quickest route a salesman should take to visit every city in a region.

The traveling salesman problem is an example of an important general problem: how to efficiently make a complete tour of a network. For example, the problem can be used to efficiently route internet data, schedule package deliveries, manage warehouse operations, and even to analyze genetically inherited DNA markers in plants. [[4]](https://www.intechopen.com/books/traveling-salesman-problem-theory-and-applications/traveling-salesman-problem-an-overview-of-applications-formulations-and-solution-approaches), [[5]](https://support.sas.com/resources/papers/proceedings12/160-2012.pdf)

To test the demo, three real-life datasets are included: the coordinates of cities in Djibouti (Africa), Qatar (Middle East), and Luxembourg (Europe). [[6]](http://www.math.uwaterloo.ca/tsp/world/countries.html) The demo features six different ant colony systems you can experiment with.

```
$ ./build.sh && ./shell.sh
```
