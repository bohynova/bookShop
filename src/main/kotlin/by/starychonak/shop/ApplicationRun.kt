package by.starychonak.shop

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import com.vaadin.flow.component.page.AppShellConfigurator
import com.vaadin.flow.theme.Theme
import com.vaadin.flow.theme.lumo.Lumo


@SpringBootApplication(scanBasePackages = ["by.starychonak.shop"])
@Theme(variant = Lumo.DARK)
class ApplicationRun: AppShellConfigurator

fun main(args: Array<String>) {
    runApplication<ApplicationRun>(args = args)
}

