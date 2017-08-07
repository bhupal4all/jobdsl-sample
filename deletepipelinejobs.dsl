def slurper = new ConfigSlurper()
// fix classloader problem using ConfigSlurper in job dsl
slurper.classLoader = this.class.classLoader
def config = slurper.parse(readFileFromWorkspace('microservices.dsl'))

// create job for every microservice
config.microservices.each { name, data -> 
    processJob("${name}-build", data)
    processJob("${name}-itest", data)
    processJob("${name}-deploy", data)
}

import jenkins.model.*;

def processJob (name, data) {
    job("${name}") {
        disabled()        
        Jenkins.instance.getItemByFullName("${name}").builds.each { it2 -> it2.delete() }
        //Jenkins.instance.getItemByFullName("${name}").delete()
    }
}

