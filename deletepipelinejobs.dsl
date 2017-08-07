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
import hudson.*;

def processJob (name, data) {
        def j = Jenkins.instance.getItemByFullName("${name}")
        if (j != null) {
            j.builds.each { it2 -> it2.delete() }
            j.checkPermission(AbstractItem.DELETE);
            j.delete()
        }
}

