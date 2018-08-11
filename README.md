# DockerGrid
An isolated , On demand and scalable Selenium Grid Architecture.

# What's that ?
A Selenium Grid Architecture that comes into existence as soon as the test execution starts , each Test Suite creates its own "Selenium Grid" and run in isolation with another Test Suite. As soon as your execution completes , You will have your results and the Selenium Grid will dispose off itself as it never existed.

# Why do we need another Selenium Grid or Execution Environment for each Test Suite, why can't we do it by simply increase the nodes ?
Well, You can ... But think of the situation where you want to execute the same code over two different environments having the same dns with different Ips e.g , your internal staging server, OR a situation where you want to execute the different codebase/git branch of your repo in parallel and your master branch is executing ...?? To solve this , you need to run your code in isolated environment where  whatever host entries you set , will not effect the whole execution process.

# How's it scalable ?
You will have the control to define the number of nodes that you want to attach to the grid before triggering your Test Suite for execution.

# Sounds convincing , How its built ?
Its built by combining and editing the official docker repositories of ubuntu and selenium, Applying some hacks on jenkins side and creating bash scripts to take care of everything.

# Great !!! , Whats the recipe for this Kung Fu ?
Not much ingredients , All you Need is :-
1) Linux Server/Linux VM
2) Docker
3) Jenkins
4) Git repositories of your Test Suite Codebase.

# Thats OK, how to join these NUTS and BOLTS ?
So the Sequence of Actions would be :-
1) Setting up docker on Linux VM/Linux Server : Check out Docker's Guide of installing it on Linux.
https://docs.docker.com/install/#releases
(Docker version 1.12.6, build 1398f24/1.12.6) recommended.

2) Setting up Jenkins(On the same server OR somehwere else you want) : Checkout Jenkins Guide of instllation .
https://jenkins.io/doc/book/installing/

3) Connecting Jenkins to the Linux VM (Checkout our Guide Link Below to see how to do that?)
4) Take a git clone of this Repo on Linux VM/Linux Server.
5) Follow the below guide to make it work :)
6) Read the README.md inside respective folder for better clarity to play with those.

