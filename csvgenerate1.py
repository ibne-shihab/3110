import csv
import math

# Set parameters
sampling_rate = 1000  # Hz
duration = 10  # seconds
num_points = sampling_rate * duration

# Generate a signal with low and high-frequency components
time = [i / sampling_rate for i in range(num_points)]
low_freq = [0.5 * math.sin(2 * math.pi * 1 * t) for t in time]  # Low-frequency component
high_freq = [0.3 * math.sin(2 * math.pi * 50 * t) for t in time]  # High-frequency component
signal = [low + high for low, high in zip(low_freq, high_freq)]

# Write to CSV
with open('filter_experiment.csv', 'w', newline='') as csvfile:
    writer = csv.writer(csvfile)
    writer.writerow(['Time', 'Signal'])
    for i in range(num_points):
        writer.writerow([time[i], signal[i]])
