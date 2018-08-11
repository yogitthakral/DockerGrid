yogitthakral/ngchromenode:67.0.3.5.3
yogitthakral(Dockerhub repo name)/ngchromenode:67.0(Browser Version).3.5.3{Selenium Version}


selenium-hub:
  image: yogitthakral/ngseleniumhub:3.5.3(Change Image name here for a different version of selenium hub and selenium )
  environment:
    GRID_BROWSER_TIMEOUT: 300000
\#    JVM_OPTS: '-Xmx512m'
  volumes:
      - /dev/shm:/dev/shm
      - /home/jenkins(replace with the linux Vm connected User with jenkins here)/.m2:/home/seluser/.m2
  ports:
  - "4444"(Don't touch it :p)

node:
  image: yogitthakral/ngchromenode:67.0.3.5.3(Change Image name here for a different version of Chrome and selenium server)
  volumes:
      - /dev/shm:/dev/shm
  environment:
    HUB_PORT_4444_TCP_ADDR: 'hub'
    NODE_MAX_INSTANCES: 3
    NODE_MAX_SESSION: 3
  links:
  - selenium-hub:hub
  \#extra_hosts:(add any host entry if required in the below lines as defined in the below example)
 \#- "www.abc.com:10.10.10.1"

