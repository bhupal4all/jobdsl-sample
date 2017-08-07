def slurper = new ConfigSlurper()
// fix classloader problem using ConfigSlurper in job dsl
slurper.classLoader = this.class.classLoader
def config = slurper.parse(readFileFromWorkspace('microservices.dsl'))

// create job for every microservice
config.microservices.each { name, data -> 
    processJob("${name}-build", data)
}

def processJob (name, data) {
    job("${name}") {
        disabled()        
        steps {
            dsl {
                removeAction('DELETE')
            }
        }
    }
}
