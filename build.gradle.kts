import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

plugins {
	id("org.springframework.boot") version "3.1.5"
	id("io.spring.dependency-management") version "1.1.3"
	id("java")
	id("org.jetbrains.kotlin.plugin.spring") version "1.8.22"
	id("com.vaadin") version "24.3.2"
	kotlin("jvm") version "1.8.22"
}

group = "by.starychonak"
version = "0.0.1-SNAPSHOT"

java {
	sourceCompatibility = JavaVersion.VERSION_17
}

repositories {
	mavenCentral()
}

val springBootVersion = "3.2.1"
val swaggerVersion = "1.7.0"

extra["swaggerVersion"] = "1.7.0"
extra["springBootVersion"] = "3.2.1"
extra["vaadinVersion"] = "24.3.2"

dependencies {
    implementation("org.springframework.boot:spring-boot-starter-web:3.2.1")
	implementation("org.springframework.boot:spring-boot-starter-data-jdbc")

	//postgresql
	implementation("org.postgresql:postgresql")

	implementation("com.fasterxml.jackson.module:jackson-module-kotlin")
	implementation("org.jetbrains.kotlin:kotlin-reflect")

	// vaadin
	implementation("com.vaadin:vaadin-spring-boot-starter")

	//liquibase
	implementation("org.liquibase:liquibase-core")
	implementation("org.liquibase:liquibase-groovy-dsl:3.0.2")

	implementation("ch.qos.logback:logback-classic")
}

dependencyManagement {
	imports {
		mavenBom("com.vaadin:vaadin-bom:${property("vaadinVersion")}")
	}
}


tasks.withType<KotlinCompile> {
	kotlinOptions {
		freeCompilerArgs += "-Xjsr305=strict"
		jvmTarget = "17"
	}
}

tasks.withType<Test> {
	useJUnitPlatform()
}