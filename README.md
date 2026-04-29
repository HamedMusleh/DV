# Digital Verification Labs (DV)

## 📌 Overview

This repository contains my coursework for the **Digital Verification (DV)** course.
It demonstrates the design and verification of digital systems using **SystemVerilog**, focusing on building a structured verification environment.

---

## 📂 Repository Structure

```
DV/
├── HW1/
├── HW2/
├── HW3/
├── HW4/
│   ├── design/
│   │   ├── my_mem.sv
│   │   └── mem_if.sv
│   ├── verif/
│   │   ├── transaction_pkg.sv
│   │   ├── test.sv
│   │   └── top.sv
│   └── flist.f
```

---

## 🧠 HW4 – Memory Verification (Main Project)

### ✔ Description

Verification of a **synchronous 8-bit RAM with parity bit** using a structured SystemVerilog testbench.

### ✔ Features

* Interface-based DUT connection
* Clocking block for timing synchronization
* Program block for test execution
* Transaction-based verification
* Random stimulus generation
* Queues for communication between components
* Checker for output validation

---

## 🔄 Verification Flow

1. Generate random transactions
2. Drive write operations into memory
3. Perform read operations
4. Capture DUT output
5. Compare output with expected results

---

## 📊 Example Waveform

The waveform demonstrates:

* Data written on the rising edge of the clock
* Data correctly read on the following clock cycle
* Proper synchronization using clocking block

---

## 🛠️ Tools Used

* **SystemVerilog**
* **Synopsys VCS**
* **Verdi (Waveform Analysis)**

---

## ✅ Results

All simulations completed successfully with:

```
ERROR COUNT = 0
```

---

## 📎 Notes

* Initial output may appear as `XXX` due to uninitialized memory
* Read operations return valid data after the next clock edge

---

## 👨‍💻 Author

**Hamed Musleh**
Computer Engineering Student

---

## 🚀 Future Improvements

* Add constrained random testing
* Introduce coverage metrics
* Extend design to support larger memory sizes
