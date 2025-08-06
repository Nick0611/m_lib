function P = HydraulicTrolleyXYZInv_2(E,l0,PS)
P = inv(E)*PS-l0;