# News

2017-02-25
Added an old simulation, start003.m - still without full polynomial trajectory tracking, I am cleaning that up, will be in next update.
draw.window now shows also the desired position for tracking. Added a simple Poincare section for stability check, shows convergence of the configuration during impact phase.

2017-02-19
A slightly newer version, a barebone one, but with correct dynamics - the last one contained a lot of errors, especially COM points.
Will try to upload the one with trajectories and more models soon.

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

Just start start_001 in Matlab.

* single_step contains ode-based simulation of a biped
* dyn_v08 contains actual dynamics equation
* dyn_v08_ev contains the events description

In +robot/ there are scripts for all the robot structures used:

* +robot/calc_ are the scripts to generate equations for different model
  +robot/+... contains saved models

# Bugs and other accidental features

Works on Matlab R2012a, other untested.
I noticed on Matlab R2016a that big .m files do not work AT ALL. Weird. I'm taking about 200kb+ files of pure mathematics, will have to check it later.

Symbolic Math Toolbox is optional for pure testing, used for dynamics derivation and analysis (singularities). Some name conflicts may arise on Windows due to a couple of functions using case-sensitive names (adjoint representations Ad() ad()).

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
