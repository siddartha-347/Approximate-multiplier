# Approximate 4x4 Bit Multiplier

This repository presents an approximation technique for a 4x4 bit multiplier based on the methods described in the paper *Design and Analysis of Approximate Multipliers*. The final implementation satisfies the following criteria:

- **Mean relative error**: Less than 15%
- **Number of LUTs**: Less than 12

## Overview

This implementation focuses on the approximation techniques used to optimize a 4x4 bit multiplier for reduced area and power consumption, with acceptable error margins.

### Approximation Techniques Used:
1. **Half Adder Approximation**
2. **Full Adder Approximation**
3. **Partial Product Transformation**
4. **Partial Product Reduction with Compressors**
5. **Final Summation**

---

## Half Adder Approximation

### Exact Implementation:
- **Sum** = A ⊕ B
- **Carry** = A ⋅ B

### Approximated Implementation:
- **Sum** = A + B
- **Carry** = A ⋅ B

#### Truth Table Comparison:

| A | B | **Exact Sum** | **Approximate Sum** | **Exact Carry** | **Approximate Carry** |
|---|---|---------------|---------------------|-----------------|-----------------------|
| 0 | 0 | 0             | 0                   | 0               | 0                     |
| 0 | 1 | 1             | 1                   | 0               | 0                     |
| 1 | 0 | 1             | 1                   | 0               | 0                     |
| 1 | 1 | 0             | 1                   | 1               | 1                     |

- **Error**: 1 out of 4 cases has an error in Sum.

---

## Full Adder Approximation

### Exact Implementation:
- **Sum** = A ⊕ B ⊕ Cin
- **Carry** = (A ⋅ B) + (B ⋅ Cin) + (Cin ⋅ A)

### Approximated Implementation:
- **Sum** = (A + B) + Cin
- **Carry** = B

#### Truth Table Comparison:

| A | B | Cin | **Exact Sum** | **Approximate Sum** | **Exact Carry** | **Approximate Carry** | **Exact Cout** | **Approximate Cout** |
|---|---|-----|---------------|---------------------|-----------------|-----------------------|----------------|----------------------|
| 0 | 0 | 0   | 0             | 0                   | 0               | 0                     | 0              | 0                    |
| 0 | 0 | 1   | 1             | 1                   | 0               | 0                     | 0              | 0                    |
| 0 | 1 | 0   | 1             | 1                   | 0               | 1                     | 0              | 1                    |
| 0 | 1 | 1   | 0             | 1                   | 1               | 1                     | 1              | 1                    |
| 1 | 0 | 0   | 1             | 1                   | 0               | 0                     | 0              | 0                    |
| 1 | 0 | 1   | 0             | 1                   | 1               | 0                     | 1              | 0                    |
| 1 | 1 | 0   | 0             | 1                   | 1               | 1                     | 1              | 1                    |
| 1 | 1 | 1   | 1             | 1                   | 1               | 1                     | 1              | 1                    |

- **Error**: 3 out of 8 cases have errors (3 in Sum and 2 in Carry).

---

## Partial Product Transformation

The approximation involves the transformation of partial product terms `am,n` and `an,m` into propagate and generate terms:

- **pm,n** = am,n + an,m
- **gm,n** = am,n ⋅ an,m

*Note: Some am,m terms are retained in the transformation.*

*Images illustrating the transformation will be added here.*

---

## Partial Product Reduction with Compressors

A compressor is used to simplify the partial product tree, processing 4 input bits and a carry-in (Cin) bit. It generates Sum, Carry, and Carry-out (Cout) bits using two approximate full adders.

### Approximated Compressor:

- **Carry** = Cin
- **Sum** = (A ⊕ B) + (C + D)
- **Carry-out (Cout)** = (A ⋅ B) + (C ⋅ D)

#### Truth Table Comparison:

| A | B | C | D | Cin | **Exact Sum** | **Approximate Sum** | **Exact Carry** | **Approximate Carry** | **Exact Cout** | **Approximate Cout** |
|---|---|---|---|-----|---------------|---------------------|-----------------|-----------------------|----------------|----------------------|
| 0 | 0 | 0 | 0 | 1   | 1             | 0                   | 0               | 0                     | 0              | 0                    |
| 0 | 0 | 0 | 1 | 1   | 0             | 1                   | 1               | 0                     | 1              | 1                    |
| 0 | 1 | 1 | 0 | 1   | 0             | 1                   | 1               | 0                     | 1              | 1                    |
| 0 | 1 | 1 | 1 | 0   | 0             | 1                   | 1               | 1                     | 1              | 1                    |
| 0 | 1 | 1 | 1 | 1   | 1             | 1                   | 1               | 1                     | 1              | 1                    |
| 1 | 0 | 0 | 0 | 1   | 0             | 1                   | 0               | 0                     | 1              | 0                    |
| 1 | 0 | 0 | 1 | 0   | 1             | 1                   | 0               | 1                     | 1              | 0                    |
| 1 | 1 | 0 | 0 | 1   | 0             | 1                   | 1               | 1                     | 0              | 1                    |
| 1 | 1 | 1 | 0 | 1   | 0             | 1                   | 1               | 1                     | 1              | 1                    |
| 1 | 1 | 1 | 1 | 0   | 1             | 1                   | 1               | 1                     | 1              | 1                    |

- **Total mismatches**: 19
  - **Sum mismatches**: 16
  - **Carry mismatches**: 8
  - **Cout mismatches**: 6

*Images illustrating the reduction process will be added here.*

---

## Final Summation

After partial product reduction, the remaining Sum and Carry-out bits are processed using half adders and full adders to generate the final output.

*Images illustrating the final summation stage will be added here.*

---

## Results and Analysis

### Performance Metrics:

- **Mean relative error**: 14.02% (less than 15%)
- **Power Utilization**: 37 mW for logic (Efficient power usage)
- **LUT Utilization**: Number of LUTs = 9 (less than 12)

---

## Contributions & Support

If you find this repository useful, feel free to contribute or donate! 

✨ Thank you for your support! ✨
