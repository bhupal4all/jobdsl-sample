def slurper = new ConfigSlurper()
// fix classloader problem using ConfigSlurper in job dsl
slurper.classLoader = this.class.classLoader
def config = slurper.parse(readFileFromWorkspace('microservices.dsl'))

// create job for every microservice
config.microservices.each { name -> 
    processJob(name)
}

def processJob (name) {
    println "processing ${name.branch}"
}
