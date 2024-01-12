package by.starychonak.shop

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication


@SpringBootApplication(scanBasePackages = ["by.starychonak.shop"])
class ApplicationRun

fun main(args: Array<String>) {
    runApplication<ApplicationRun>(args = args)
}

