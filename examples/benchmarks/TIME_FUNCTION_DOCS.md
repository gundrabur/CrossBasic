# TIME Function Documentation

## Overview
The `TIME()` function in CrossBasic returns the current time as a floating-point number representing seconds since the Unix epoch (January 1, 1970). This function is primarily designed for benchmarking and performance measurement of BASIC programs.

## Syntax
```basic
TIME()
```

## Returns
- **Type**: Number (floating-point)
- **Value**: Current time in seconds since Unix epoch
- **Precision**: Microsecond precision (depending on system)

## Common Usage Patterns

### Basic Timing
```basic
10 PRINT "Current time:", TIME()
```

### Measuring Execution Time
```basic
10 LET START_TIME = TIME()
20 REM ... your code to benchmark ...
30 LET END_TIME = TIME()
40 LET ELAPSED = END_TIME - START_TIME
50 PRINT "Execution took", ELAPSED, "seconds"
```

### Performance Comparison
```basic
10 REM Compare two different algorithms
20 LET START1 = TIME()
30 REM Algorithm 1
40 LET TIME1 = TIME() - START1

50 LET START2 = TIME()
60 REM Algorithm 2  
70 LET TIME2 = TIME() - START2

80 PRINT "Algorithm 1:", TIME1, "seconds"
90 PRINT "Algorithm 2:", TIME2, "seconds"
```

## Example Programs

### Simple Loop Benchmark
```basic
REM Test loop performance
10 LET START = TIME()
20 FOR I = 1 TO 10000
30 NEXT I
40 LET ELAPSED = TIME() - START
50 PRINT "10000 iterations in", ELAPSED, "seconds"
```

### Mathematical Operations Benchmark
```basic
REM Test math function performance
10 LET START = TIME()
20 FOR I = 1 TO 1000
30 LET X = SQR(I) + SIN(I) + COS(I)
40 NEXT I
50 LET ELAPSED = TIME() - START
60 PRINT "1000 math ops in", ELAPSED, "seconds"
```

### Graphics Performance Test
```basic
REM Test graphics rendering speed
10 GRAPHICS
20 LET START = TIME()
30 FOR I = 1 TO 1000
40 PLOT I MOD 800, I MOD 600
50 NEXT I
60 LET ELAPSED = TIME() - START
70 PRINT "1000 pixels in", ELAPSED, "seconds"
```

## Tips for Accurate Benchmarking

1. **Warm-up runs**: Run your code once before timing to account for initialization overhead
2. **Multiple measurements**: Take several measurements and average them
3. **Sufficient iterations**: Use enough iterations to get measurable time differences
4. **Minimize other operations**: Keep timing code simple to avoid overhead

## Precision Notes

- The TIME() function provides high precision timing suitable for most benchmarking needs
- On most systems, precision is in microseconds
- For very fast operations, you may need to run many iterations to get measurable results

## Use Cases

- **Algorithm performance comparison**
- **Graphics rendering benchmarks** 
- **Mathematical computation timing**
- **Loop optimization testing**
- **General code profiling**

The TIME function makes CrossBasic suitable for performance analysis and optimization of BASIC programs.
