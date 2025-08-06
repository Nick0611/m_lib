
function traj_sphere_global = SphereJointTrajectory_Inv(g,PS_in_B)
num_Interpolation = length(g);

for i=1:num_Interpolation
    traj_sphere_global(:,i) = NonHomo_g(g{i},PS_in_B,1);
end