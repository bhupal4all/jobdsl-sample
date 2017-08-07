def slurper = new ConfigSlurper()
// fix classloader problem using ConfigSlurper in job dsl
slurper.classLoader = this.class.classLoader
def config = slurper.parse(readFileFromWorkspace('microservices.dsl'))

// create job for every microservice
config.microservices.each { name ->
  job(${name}-build) {
    disabled();
  }  
  job(${name}-itest) {
    disabled();
  }  
  job(${name}-deploy) {
    disabled();
  }  
}
