# About

Just a collection of scripts I am using in simulation of a bipedal robot
- with arms and feet
- modelling done from translations, then rotations starting from torso
- impact model
- multi-point contact and support model (also, ability to fly)
- take-off phase based on forces/ lagrange multipliers (spatial accelerations as an alternative)
- partial feedback linearisation as a default control method

Maintainer: Adam Lukomski <lukomski@zut.edu.pl>

# License and usage

If you use it - and you know you use it at your own risk, I'm not really sure the equations are 100% correct - please cite the corresponding paper that describes the equations behind each part of the project. Most of them in .pdf are available at <http://lukomski.zut.edu.pl/papers>

- singularities: (to be added in next update!)
  Dynamic singularities in nonlinear control of underactuated pendulum-like models
  http://ieeexplore.ieee.org/xpls/abs_all.jsp?arnumber=6957385
- modelling and basic walking: 
  Framework for Whole-body Control of a Planar Biped During Different Support Phases
  (to appear)

# How to use

Just start test_v06 in Matlab.

* test_v06 contains ode-based simulation of a biped
* dyn_v06 contains actual dynamics equation
* dyn_v06_ev contains the events description

* basic_triple_pendulum is a start point for triple pendulum simulation

In +robot/ there are scripts for all the robot structures used:

* +robot/calc_triple.m is a script to generate equations for triple pendulum
  +robot/+triple/out_eva.mat contains saved model

* +robot/calc_fullbody_arms.m is a script to generate equations for a full planar humanoid robot
  +robot/+fullbody/out_eva.mat contains saved model

# Bugs and other accidental features

Works on Matlab 2012a, other untested.
Symbolic Math Toolbox is optional for pure testing, used for dynamics derivation and analysis (singularities)

Visible bugs:
- Support model - still has a tendency to let points fall through ground, especially when controlled.
- when using (tx,tz) as translation tz has to have mass, otherwise torso will not rotate at all

# References, credits, copy-paste and based-on notes

Kinematics
- Murray, Li, Sastry, A Mathematical Introduction to Robotic Manipulation
- Selig, Interpolated Rigid-Body Motions and Robotics
Dynamics
- Selig, Geometric fundamentals of robotics
Redundant inv kin
- Altafini, Redundant robotic chains on Riemannian submersions

function write_full is a slightly modified version of write_fcn by Morris, Westervelt 2007
- Westervelt, Grizzle, Feedback control of dynamic bipedal robot locomotion
