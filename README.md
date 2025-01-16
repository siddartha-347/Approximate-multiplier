# Approximate 4x4 Bit Multiplier

This repository presents an approximation technique for a 4x4 bit multiplier based on the methods described in the paper [Design and Analysis of Approximate Multipliers](https://www.researchgate.net/publication/368293010). The final implementation satisfies the following criteria:

- **Mean relative error**: Less than 15%
- **Number of LUTs**: Less than 12
- approximations for the approximate compressor were by my own and rest of the approximations are from the described paper.

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

![Compressor](https://github.com/user-attachments/assets/73b149aa-197c-4791-a304-311b5eeb2f61)


---

## Final Summation

After partial product reduction, the remaining Sum and Carry-out bits are processed using half adders and full adders to generate the final output.

*Images illustrating the final summation stage will be added here.*


![Mean_relative _error](https://github.com/user-attachments/assets/cdea8e6b-9fe6-4362-91a4-9fccf34c19b3)
![Schematic_diagram](https://github.com/user-attachments/assets/cde7409c-9cc6-46fa-886c-49f60e34cb01)
![luts](https://github.com/user-attachments/assets/f6f06d7e-625c-45c7-b249-edad87b7663a)
![Power_consumption](https://github.com/user-attachments/assets/b6fc21f1-ae2c-4a14-a36b-2e541c838938)

---

## Results and Analysis

### Performance Metrics:

- **Mean relative error**: 14.02% (less than 15%)
- **Power Utilization**: 37 mW for logic (Efficient power usage)
- **LUT Utilization**: Number of LUTs = 9 (less than 12)

---

## Contributions & Support
Thanking PaAC team for helping out with this project especially to those who were associated with Approximate Multipliers.🙏

If you find this repository useful, feel free to contribute or donate! 🙏🙏

<img src="https://github.com/user-attachments/assets/5d331d78-8ce1-49d8-91f8-19933a8098d2" width="85" height="200" />

Thank you for your support! ✨
