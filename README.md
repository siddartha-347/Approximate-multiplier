# Approximate-multiplier
it is about approximate multipliers
# Approximation Technique for a 4x4 Bit Multiplier

This repository presents an approximation technique for a 4x4 bit multiplier based on the methods described in the paper **"Design and Analysis of Approximate Multipliers"**. The final implementation satisfies the following criteria:

- **Mean relative error:** Less than 15%
- **Number of LUTs:** Less than 12

---

## Overview
This project implements a 4x4 bit multiplier using approximation techniques to reduce complexity and resource utilization while maintaining acceptable error levels.

---

## Approximation Techniques

### Half Adder
#### Exact Implementation:
- **Sum = A ⊕ B**
- **Carry = A ⋅ B**

#### Approximated Implementation:
- **Sum = A + B**
- **Carry = A ⋅ B**

| A | B | Exact  | Approximate |
|---|---|--------|-------------|
|   |   | **Sum** | **Carry** | **Sum** | **Carry** |
| 1 | 1 | 0      | 1         | 1      | 1         |

**Error:** 1 out of 4 cases has an error in `Sum`.

---

### Full Adder
#### Exact Implementation:
- **Sum = A ⊕ B ⊕ Cin**
- **Carry = (A ⋅ B) + (B ⋅ Cin) + (Cin ⋅ A)**

#### Approximated Implementation:
- **Sum = (A + B) + Cin**
- **Carry = B**

| A | B | Cin | Exact        | Approximate |
|---|---|-----|--------------|-------------|
|   |   |     | **Sum** | **Carry** | **Sum** | **Carry** |
| 0 | 0 | 1   | 1      | 0         | 0      | 0         |
| 0 | 1 | 1   | 0      | 1         | 1      | 0         |
| 1 | 0 | 0   | 1      | 0         | 0      | 1         |
| 1 | 1 | 0   | 0      | 1         | 1      | 1         |

**Error:** 4 out of 8 cases have errors: 4 in `Sum` and 2 in `Carry`.

---

### Partial Product Transformation
The approximation involves the transformation of partial product terms `am,n` and `an,m` into propagate and generate terms:

- **pm,n = am,n + an,m**
- **gm,n = am,n ⋅ an,m**

`am,m` terms are retained.

**Images** will be added to demonstrate the transformation process:
- Placeholder for partial product transformation images.

---

### Partial Product Reduction with Compressors
A compressor is used to simplify the partial product tree. It takes 4 input bits and a carry-in (Cin) bit and generates `Sum`, `Carry`, and `Carry-out (Cout)` bits.

#### Exact Compressor:
The exact compressor uses two approximate full adders:
1. The first full adder takes 3 input bits and generates:
   - **Intermediate Sum**
   - **Carry-out (Cout)**
2. The second full adder takes:
   - **Intermediate Sum**
   - **4th input bit**
   - **Carry-in (Cin)**
   
and generates the final **Sum** and **Carry** bits.

#### Approximated Compressor:
- **Carry = Cin**
- **Sum = (A ⊕ B) + (C + D)**
- **Carry-out (Cout) = (A ⋅ B) + (C ⋅ D)**

| A | B | C | D | Cin | Exact        | Approximate |
|---|---|---|---|-----|--------------|-------------|
|   |   |   |   |     | **Sum** | **Carry** | **Cout** | **Sum** | **Carry** | **Cout** |
| 0 | 0 | 0 | 0 | 1   | 1      | 0         | 0       | 0      | 1         | 0        |
| 0 | 0 | 0 | 1 | 1   | 0      | 1         | 0       | 1      | 1         | 0        |
| 0 | 0 | 1 | 0 | 1   | 0      | 1         | 0       | 1      | 1         | 0        |
| 0 | 0 | 1 | 1 | 0   | 0      | 1         | 0       | 0      | 0         | 1        |
| 0 | 0 | 1 | 1 | 1   | 1      | 1         | 0       | 0      | 1         | 1        |

**Error:** 20 out of 32 cases have errors: 16 in `Sum`, 8 in `Carry`, and 6 in `Cout`.

**Images** will be added for:
- Placeholder for 1st stage of reduction.

---

## Final Summation
After the partial product reduction, the remaining `Sum` and `Carry-out` bits are processed using half adders and full adders to generate the final output.

**Image** will be added for:
- Placeholder for final summation stage.

---

## Results and Analysis
The design meets the specified criteria:

- **Error:** Mean relative error = 14.02% (less than 15%)
- **Power Utilization:** 37 mW for logic (Efficient power usage)
- **LUT Utilization:** Number of LUTs = 9 (less than 12)

---

## Contributions
If you find this project useful, feel free to show your support! 🙏

---
