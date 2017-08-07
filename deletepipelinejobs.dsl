def slurper = new ConfigSlurper()
// fix classloader problem using ConfigSlurper in job dsl
slurper.classLoader = this.class.classLoader
def config = slurper.parse(readFileFromWorkspace('microservices.dsl'))

// create job for every microservice
config.microservices.each { name, data ->
  deleteBuildJob(name,data)
}

def deleteBuildJob(name,data) {
  job($name) {
    disabled(true);
  }  
}
