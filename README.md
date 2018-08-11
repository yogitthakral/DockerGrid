# DockerGrid
An isolated , On demand and scalable Selenium Grid Architecture.

# What's that ?
A Selenium Grid Architecture that comes into existence as soon as the test execution starts , each Test Suite creates its own "Selenium Grid" and run in isolation with another Test Suite. As soon as your execution completes , You will have your results and the Selenium Grid will dispose off itself as it never existed.


# How's it scalable ?
You will have the control to define the number of nodes that you want to attach to the grid before triggering your Test Suite for execution.

# How's it on demand ?
You will utilize hardware resources only when needed for test execution. System resources will be freed once execution is completed and can be utlized to combine more number of nodes required for a different test suite execution.

# Sounds convincing , How its built ?
Its a dockerized test execution environment. Its built by combining and editing the official docker repositories of ubuntu and selenium, Applying some hacks on jenkins configuration side and creating bash scripts to take care of everything.

# Great !!! , Whats the recipe for this Kung Fu ?
Not much ingredients , All you Need is :-
1) Linux Server/Linux VM
2) Docker
3) Jenkins
4) Git repositories of your Test Suite Codebase.

# Thats OK, how to join these NUTS and BOLTS ?
So the Sequence of Actions would be :-
1) Installing linux on VM/Server (CentOS Linux release 7.2.1511 (Core) recommended).
2) Setting up docker on Linux VM/Linux Server : Check out Docker's Guide of installing it on Linux.
https://docs.docker.com/install/#releases
(Docker version 1.12.6, build 1398f24/1.12.6) recommended.

3) Setting up Jenkins(On the same server OR somehwere else you want) : Checkout Jenkins Guide of instllation .
https://jenkins.io/doc/book/installing/

4) Connecting Jenkins to the Linux VM (Checkout our Guide Link Below to see how to do that?)
5) Take a git clone of this Repo on Linux VM/Linux Server.
6) Follow the below guide to make it work :)
7) Read the README.md inside respective folder for better clarity to play with those.

