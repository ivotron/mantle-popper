Hi.

To interactively explore graphs, download all files and run:

   $ tar xzf baseliner.tar.gz
   $ cd baseliner; ./jupyter.sh

This launches Jupyter in a container and gives you a nice WebUI to view your
results. In the WebUI, click on graphs/visualize.ipynb to change or re-plot the
graphs.  You may haveto mangle the ports if your environment only has certain
ports open (check the ./jupyter.sh file for an example). To simply re-graph
everything you see on Jenkins, run:

   ./plot.sh

For all information about this run, (configuration files, system setup,
containers used, how we ran the benchmarks, etc.), see the Jenkins workspace
for this run.
