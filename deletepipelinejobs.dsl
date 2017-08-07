def slurper = new ConfigSlurper()
// fix classloader problem using ConfigSlurper in job dsl
slurper.classLoader = this.class.classLoader
def config = slurper.parse(readFileFromWorkspace('microservices.dsl'))

// create job for every microservice
config.microservices.each { name, data -> 
    processJob(name, data)
}

def processJob (name, data) {
    println "processing ${name}"
    println "branch: ${data.branch}"
    
    job("${name}-build") {
        description("modified")
        disabled()
          steps {
            shell('echo "I live!")
          }
    }
}
