# 🦠 SEIR Pandemic Flu Simulation – MATLAB

This project implements a deterministic SEIR (Susceptible–Exposed–Infectious–Recovered) model to simulate the spread of a pandemic flu under multiple public health intervention scenarios.

> 🔬 Developed as part of the ISyE 6644 Summer 2025 course (Georgia Tech)  
> 📊 Written in MATLAB using `ode45` for ODE solving and scenario visualization  
> 🧪 Simulated 13 distinct public health strategies such as lockdowns, vaccinations, improved healthcare, and variant emergence.

---

## 📁 Project Structure

```
SEIR_Model/
├── seir_all_scenarios.m      # Main script (entry point)
├── seir_ode.m                # Static SEIR ODE system
├── SEIR_Output/              # Output PNG plots for each scenario
├── ISYE_6644_Team153_final_report.pdf  # Final project report
└── README.md
```

---

## ⚙️ How to Run

1. Open **MATLAB**  
2. Navigate to the folder containing `seir_all_scenarios.m`
3. Run the following in the Command Window:

```matlab
seir_all_scenarios()
```

4. The simulation will iterate through predefined scenarios and save one plot per scenario as a PNG file to the `SEIR_Output/` directory.

---

## 🧠 Scenarios Simulated

| # | Description | Parameter Modified |
|--:|-------------|--------------------|
| 0 | Baseline (No intervention) | β = 0.5 |
| 1 | Reduced β (0.25 and 0.1) | Lower transmission |
| 2 | Increased γ (1/5 and 1/3) | Faster recovery |
| 3 | Modified σ (1/3 and 1/7) | Incubation period |
| 4 | Partial Vaccination (30%, 60%) | Reduced S₀ |
| 5 | Higher I₀ (10, 100) | Initial infection size |
| 6 | Early lockdown (Day 20) | Dynamic β |
| 7 | Variant emergence (Day 70) | Increased β and σ |

See `ISYE_6644_Team153_final_report.pdf` for detailed results and figures.

---

## 📄 Requirements

- MATLAB R2023a or later  
- No additional toolboxes needed  
