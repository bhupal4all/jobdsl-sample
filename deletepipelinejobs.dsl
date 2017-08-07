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
//        def j = jenkins.model.Jenkins.instance.getItem("${name}")
//        j.builds.each { it.delete() }
//        j.delete()
        println Jenkins.instance.getItemByFullName("${name}")
        Jenkins.instance.getItemByFullName("${name}").builds.each { it.delete() }
    }
}

