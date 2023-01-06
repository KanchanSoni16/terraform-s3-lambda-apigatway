#!/bin/bash
terraform graph > graph.dot
cat ./graph.dot | dot -Tsvg > graph.svg
