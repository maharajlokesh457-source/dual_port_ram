# dual_port_ram
Verilog HDL implementation of a synchronous dual-port RAM with independent read/write ports, including RTL design, self-checking testbench, and documentation
# Dual-Port RAM – Verilog HDL

A synthesizable **Dual-Port RAM** design implemented using **Verilog HDL**, with a self-checking simulation testbench.

## 📌 Overview

Dual-Port RAM is a memory architecture that provides **two independent access ports** to a shared memory array.

Each port has its own:

* Clock
* Write Enable
* Address
* Data Input
* Data Output

This allows two independent operations to access the memory.

```text
                 ┌───────────────────────┐
                 │                       │
    Port A ─────►│                       │
                 │    DUAL-PORT RAM      │
                 │                       │
    Port B ─────►│                       │
                 │                       │
                 └───────────────────────┘
```

## 🎯 Objectives

The objectives of this project are:

1. Design a synthesizable Dual-Port RAM using Verilog HDL.
2. Provide independent read/write access through two ports.
3. Support independent clocks for both ports.
4. Verify memory read and write operations using a testbench.
5. Demonstrate simultaneous access to shared memory.
6. Create a reusable and parameterized RTL design.

## ⚙️ Design Specifications

| Specification       | Value              |
| ------------------- | ------------------ |
| HDL                 | Verilog HDL        |
| RAM Type            | Dual-Port RAM      |
| Data Width          | 8 bits             |
| Address Width       | 4 bits             |
| Memory Depth        | 16 locations       |
| Memory Organization | 16 × 8             |
| Number of Ports     | 2                  |
| Read Type           | Synchronous        |
| Clock               | Independent clocks |
| Reset               | Not required       |

## 🔌 Port A

Port A contains:

| Signal       | Description           |
| ------------ | --------------------- |
| `clk_a`      | Port A clock          |
| `we_a`       | Port A write enable   |
| `addr_a`     | Port A memory address |
| `data_in_a`  | Port A input data     |
| `data_out_a` | Port A output data    |

When `we_a = 1`, data is written to the selected memory location.

When `we_a = 0`, the selected memory location is read.

## 🔌 Port B

Port B contains:

| Signal       | Description           |
| ------------ | --------------------- |
| `clk_b`      | Port B clock          |
| `we_b`       | Port B write enable   |
| `addr_b`     | Port B memory address |
| `data_in_b`  | Port B input data     |
| `data_out_b` | Port B output data    |

Port B operates independently from Port A.

## 🧠 Memory Organization

With:

```text
DATA_WIDTH = 8
ADDR_WIDTH = 4
```

the number of memory locations is:

```text
2^ADDR_WIDTH
= 2^4
= 16
```

Therefore, the RAM organization is:

```text
16 locations × 8 bits
```

Memory addresses range from:

```text
0000 → 1111
```

or:

```text
0 → 15
```

## 🔄 Operation

### Write Operation

When the write enable is high:

```text
we = 1
```

data is stored at the selected address.

Example:

```text
Address  = 4'd3
Data     = 8'hAA
we       = 1
```

After the clock edge:

```text
Memory[3] = AA
```

### Read Operation

When:

```text
we = 0
```

the data stored at the selected address is available at the output after the active clock edge.

Example:

```text
Address = 4'd3
```

If:

```text
Memory[3] = 8'hAA
```

then:

```text
data_out = 8'hAA
```

## 🔀 Simultaneous Access

One of the main advantages of Dual-Port RAM is that both ports can access memory independently.

For example:

```text
Port A:
Address = 5
Write   = F0

Port B:
Address = 9
Write   = 0F
```

Both operations can occur independently.

```text
             Dual-Port RAM
           ┌───────────────┐
Port A ───►│ Address 5 = F0│
           │               │
Port B ───►│ Address 9 = 0F│
           └───────────────┘
```

## 📁 Repository Structure

```text
dual-port-ram-verilog/
│
├── rtl/
│   └── dual_port_ram.v
│
├── tb/
│   └── tb_dual_port_ram.v
│
├── DESCRIPTION.md
└── README.md
```

## 🧪 Verification

The testbench verifies:

* Port A write
* Port B read
* Port B write
* Port A read
* Simultaneous writes
* Cross-port data access
* Expected versus actual output data

The testbench uses `$display` messages to report PASS/FAIL status.

## ▶️ Simulation Using Icarus Verilog

Install Icarus Verilog and execute:

```bash
iverilog -o dual_port_ram_sim rtl/dual_port_ram.v tb/tb_dual_port_ram.v
```

Run the simulation:

```bash
vvp dual_port_ram_sim
```

Expected output will contain messages similar to:

```text
Test 1: Port A wrote AA to address 3
Test 2 PASS: Port B read AA from address 3
Test 3: Port B wrote 55 to address 7
Test 4 PASS: Port A read 55 from address 7
Test 5: Simultaneous writes completed
Test 6 PASS: Port B read F0 from address 5
Test 7 PASS: Port A read 0F from address 9
--------------------------------------
Dual-Port RAM Testbench Completed
--------------------------------------
```

## 📊 Verification Concept

The basic verification flow is:

```text
        Start
          │
          ▼
   Initialize Signals
          │
          ▼
    Write using Port A
          │
          ▼
    Read using Port B
          │
          ▼
    Write using Port B
          │
          ▼
    Read using Port A
          │
          ▼
 Simultaneous Operations
          │
          ▼
   Compare Expected Data
          │
          ▼
     PASS / FAIL
          │
          ▼
         End
```

## 🛠️ Tools

The project can be simulated using:

* Icarus Verilog
* GTKWave
* ModelSim
* QuestaSim
* Vivado Simulator

## 🚀 Possible Enhancements

The design can be extended with:

* Configurable RAM depth
* Configurable data width
* Reset functionality
* Byte-enable support
* Read-first/write-first/no-change modes
* Synchronous reset
* Asynchronous read
* True dual-port RAM
* RAM initialization
* Assertion-based verification
* Functional coverage
* SystemVerilog/UVM verification environment

## 🎓 Learning Outcomes

After completing this project, you can understand:

* RAM architecture
* Dual-port memory operation
* Verilog memory arrays
* Synchronous read/write operations
* Multiple clock domains
* Parameterized RTL design
* Synthesizable Verilog coding
* RTL verification
* Self-checking testbenches

## 👨‍💻 Author

**K. Lokesh Babu**

VLSI Design & Verification | Verilog HDL | SystemVerilog | Digital Design

## 📜 License

This project is intended for educational and academic purposes.
