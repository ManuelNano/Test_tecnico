#!/usr/bin/python
# -*- coding: utf-8 -*-

import math
from collections import namedtuple
import pandas as pd
import numpy as np
import random

Point = namedtuple("Point", ['x', 'y'])

def solve_it(input_data):
    # Modify this code to run your optimization algorithm
    random.seed(123)
    # parse the input
    lines = input_data.split('\n')
    nodeCount = int(lines[0])
    points = []
    

    for i in range(1, nodeCount+1):
        line = lines[i]
        parts = line.split()
        points.append(Point(float(parts[0]), float(parts[1])))

    # Modify this to create a better solution

    solution=[0]            
    for i in solution:
        l=float("Inf") 
        for j in range(1,nodeCount):
          if j in solution:
            continue
          else:
            s=abs(points[i].x-points[j].x)+abs(points[i].y-points[j].y)
            l=min(l,s)
            if l==s:
                ngbr=j
        solution.append(ngbr)
        if len(solution)==nodeCount:
            break

    solution.append(solution[0])

    return solution


def distancia(point1, point2):
    return math.sqrt((point1.x - point2.x)**2 + (point1.y - point2.y)**2)

def distancia_total(solution, nodeCount, points):
    objective=0
    for j in range(nodeCount):
        objective = objective + distancia_total(points[solution[j]],points[solution[j+1]])
    return objective


if __name__ == '__main__':
    file_location = "./tsp_70_1"
    with open(file_location, 'r') as input_data_file:
        input_data = input_data_file.read()
    print(solve_it(input_data))
