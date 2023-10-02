plugins {
    java
    id("software.amazon.smithy").version("0.6.0")
}

buildscript {
    repositories {
        mavenLocal()
        mavenCentral()
    }

    dependencies {
        classpath("software.amazon.smithy:smithy-openapi:[1.0, 2.0[")
        classpath("software.amazon.smithy:smithy-aws-traits:[1.0, 2.0[")
    }
}

configure<software.amazon.smithy.gradle.SmithyExtension> {
    projection = "default"
    outputDirectory = file(layout.buildDirectory.file("smithyprojections").get())
}

repositories {
    mavenLocal()
    mavenCentral()
}

dependencies {
    implementation("software.amazon.smithy:smithy-model:[1.0, 2.0[")

    // The dependency for restJson1 is required here too.
    implementation("software.amazon.smithy:smithy-aws-traits:[1.0, 2.0[")
}

tasks.register<Copy>("copyOpenapi") {
    dependsOn(":smithyBuildJar")
    from(layout.buildDirectory.dir("smithyprojections/default/openapi"))
    into(layout.projectDirectory.dir("smithyprojections/openapi"))
}

tasks.register("release") {
    dependsOn(tasks.withType<Copy>())
}