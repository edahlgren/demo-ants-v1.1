# Build the demo:

$ ./build.sh

# Run the demo on fake (generated) data:

$ ./run.sh -i data/fake_docs.csv
positions.csv

# Run the demo on real data:

$ ./run.sh -i data/wine.csv --use-cosine
positions.csv

# Visualize the cluster:

$ ./visualize.sh positions.csv
positions.svg
