import numpy as np
import matplotlib
import matplotlib.pyplot as plt
# matplotlib.use('TkAgg')

STEP_SIZE = 0.01
MAP_SIZE = 101

SEP = ";"


class PassMap:
  '''A 2-D histogram suitable for actual and predicted pass frequencies.'''

  def __init__(self):
    self.matrix = np.zeros((MAP_SIZE, MAP_SIZE))


  def float2index(self, value):
    '''Convert a float to an index.'''
    if (value == 0.):
      return 0
    elif (value == 1.):
      return MAP_SIZE-1
    else:
      return int(value/STEP_SIZE) + 1


  def add(self, freq_actual, freq_predicted):
    '''Add a data point.'''
    index1 = self.float2index(freq_actual)
    index2 = self.float2index(freq_predicted)
    print("Adding", freq_actual, freq_predicted, index1, index2)
    self.matrix[index1][index2] += 1

  
  def correlate(self, drop00_flag):
    '''Calculate a correlation of the histogram.'''
    # TODO Implement drop00_flag.

    # Generate the bin centers
    x = y = np.arange(MAP_SIZE)

    # Calculate the weighted means
    sum = np.sum(self.matrix)
    mean_x = np.sum(x * self.matrix.sum(axis=1)) / sum
    mean_y = np.sum(y * self.matrix.sum(axis=0)) / sum

    # Calculate the weighted standard deviations
    std_x = np.sqrt(np.sum(self.matrix.sum(axis=1) * (x - mean_x)**2) / sum)
    std_y = np.sqrt(np.sum(self.matrix.sum(axis=0) * (y - mean_y)**2) / sum)

    correlation = np.sum((x - mean_x) * (y - mean_y) * self.matrix) / \
      (std_x * std_y * sum)

    return correlation


  def strCSV(self):
    '''Return a CSV field.'''
    return '\n'.join(SEP.join(map(str, row)) for row in self.matrix)

  
"""
  def plot(self):
    '''Make a heatmap.'''
    plt.imshow(self.matrix, origin='lower', cmap='jet')
    plt.colorbar(label = 'Frequency')
    plt.title('Heatmap')
    plt.xlabel('Actual')
    plt.ylabel('Predicted')
    plt.show()
"""

