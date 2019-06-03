# simple-spring-boot application 'ping-pong'

To build docker image use following command:

   ./deploy.sh build \<version\>
   
   for example to build two docker images with different application version use following:
   
   ./deploy.sh build 0.1.11
   
   ./deploy.sh build 0.1.10

To deploy application to minikube use following command:

  ./deploy.sh initial
  
  it will deploy application with current application version defined in pom.xml
  
To update application in minikube use folliving command:

  ./deploy.sh update 0.1.11
  
  if current version application version is 0.1.10
  
  or
  
  ./deploy.sh update 0.1.10
  
  if current version application version is 0.1.11
  
If deploy.sh complete deployment without error it show url to application accsess.

You can use following requests:

/ping        - to get 'pong'

/version     - to get version

/actuator/health
