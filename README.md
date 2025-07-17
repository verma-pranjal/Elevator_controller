# 🚪 Elevator Controller (Verilog)

This project implements a simple **4-floor elevator controller** using Verilog HDL. It handles user requests to move between floors, opens/closes doors, and manages upward and downward motion based on pending requests.

## 📁 Files Included

- `Elevator_controller.v` — Main Verilog module that contains the elevator control FSM.
- `Elevator_controller_tb.v` — Testbench to simulate the behavior of the elevator controller.
- `README.md` — Project documentation.

---
<img width="1564" height="868" alt="image" src="https://github.com/user-attachments/assets/607ad814-9cb4-4adf-9fcf-922518fc98f1" />


## ⚙️ Module Description

### 📌 Module Name: `Elevator_controller`

#### **Inputs:**
| Signal | Width | Description |
|--------|-------|-------------|
| `clk` | 1 bit | System clock |
| `reset` | 1 bit | Active high reset |
| `req` | 4 bits | Request signals for floors 0 to 3 |

#### **Outputs:**
| Signal | Width | Description |
|--------|-------|-------------|
| `up` | 1 bit | Elevator moving up |
| `down` | 1 bit | Elevator moving down |
| `door_open` | 1 bit | Door open signal |
| `curr_floor` | 2 bits | Current floor of the elevator |

---

## 🔄 Functionality

- Elevator starts in an IDLE state.
- On receiving a request via the `req` signal, it moves either **up** or **down** to reach the requested floor.
- Once at the requested floor, it sets `door_open = 1` to simulate the door opening.
- Requests are latched and cleared after servicing.
- The FSM ensures that multiple requests are handled in an efficient sequence.

---

## 🧪 Simulation

To simulate the project, use any Verilog simulator (e.g., ModelSim, Icarus Verilog).

<img width="1907" height="950" alt="image" src="https://github.com/user-attachments/assets/4da6287e-1b6c-4892-89a9-002935d4cc18" />


### Steps using Icarus Verilog:

```bash
# Compile the design and testbench
iverilog -o elevator_sim Elevator_controller.v Elevator_controller_tb.v

# Run the simulation
vvp elevator_sim

## this project is made by **Pranjal Verma**
