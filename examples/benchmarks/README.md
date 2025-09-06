# CrossBasic Benchmarks

This folder contains benchmarking examples and documentation for the CrossBasic interpreter's TIME function.

## Files

### Benchmark Examples
- `benchmark_test.bas` - Comprehensive benchmark testing various BASIC operations
- `mandelbrot_benchmark.bas` - Performance test for the Mandelbrot fractal calculation
- `time_examples.bas` - Various examples demonstrating TIME function usage
- `time_test_simple.bas` - Simple timing demonstration

### Documentation
- `TIME_FUNCTION_DOCS.md` - Complete documentation for the TIME() function

## TIME Function

The TIME() function returns the current time as a floating-point number representing seconds since epoch with microsecond precision. This allows for accurate benchmarking of BASIC code performance.

### Usage Example
```basic
10 START_TIME = TIME()
20 FOR I = 1 TO 1000: NEXT I
30 END_TIME = TIME()
40 PRINT "Loop took "; (END_TIME - START_TIME); " seconds"
```

## Running Benchmarks

To run any benchmark:
```bash
python3 crossbasic.py
LOAD "examples/benchmarks/benchmark_test.bas"
RUN
```

All benchmarks are designed to provide meaningful performance metrics for various aspects of the CrossBasic interpreter.
