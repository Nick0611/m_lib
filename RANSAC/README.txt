RANSAC Toolbox by Marco Zuliani
email: marco.zuliani@gmail.com
-------------------------------

Introduction
------------

	This is a research (and didactic) oriented toolbox to explore the RANSAC algorithm. The functions are reasonably well documented and there is a directory containing examples to estimate 2D lines, 3D planes and homographies in presence of outliers. However a previous exposure to the algorithm may be very helpful in understanding the options available. I am currently trying to finish a tutorial, a sort of RANSAC for dummies, but it is still work in progress: keep an eye on my web page (vision.ece.ucsb.edu/~zuliani)
	If you add other examples (i.e. other estimators) please contact me and we can try to improve the package. Of course I also expect some feedback regarding the bugs that might still be present...

How To Start
------------
CD to the root directory (i.e. whatever/RANSAC) and launch the script SetLocalPath. Then you may start playing around. Give a look to the folder whatever/RANSAC/Examples where you can find two examples for the estimation of homographies and lines. Templates for the estimation functions and the model fitting error functions can be found in whatever/RANSAC/Models.

Extras
------
Contains the routines to estimate an homography using the normalized DLT algorithm

Warning
-------
The examples clear the workspace. I noticed that this raised some concerns by some users in this forum, however I believe that sometimes (like in this case) it is an appropriate choice.

License
-------
This toolbox is distributed under the terms of the GNU LGPL. Please refer to the files COPYING and COPYING.LESSER for more information. 

Acknowledgments
---------------
I would like to thank the following people for their useful feedback:

Tamar Back 		- suggested to check the parameter sigma
David Portabella Clotet - pointed out two bugs
Zhe Zang		- noted a ill conditioning related warning in the homography estimation routines

If you plan to use this software package in and referenced published material (e.g. conferences, journals, workshops...) an acknowledgment will be greatly appreciated as well as a copy of your publication.

Updates History
---------------

- 29 June 2008: Included the ind_tabu and seed_fix options. Modified the interface for the estimation routines and the fitting error routines. Improved the documentation. Some other general improvements.
- 10 July 2008: Included the routines for 3D plane estimation. Fixed a bug in the threshold selection for lines. Some other general improvements and fixes in the help of the functions.


Thanks for your interest,
Marco Zuliani