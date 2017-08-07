def slurper = new ConfigSlurper()
// fix classloader problem using ConfigSlurper in job dsl
slurper.classLoader = this.class.classLoader
def config = slurper.parse(readFileFromWorkspace('microservices.dsl'))

// create job for every microservice
config.microservices.each { name ->
  job(${name}-build) {
    disabled(true);
  }  
  job(${name}-itest) {
    disabled(true);
  }  
  job(${name}-deploy) {
    disabled(true);
  }  
}
