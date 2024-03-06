package by.starychonak.shop.view

import by.starychonak.shop.service.UserService
import by.starychonak.shop.utils.Utils
import com.vaadin.flow.component.ComponentEventListener
import com.vaadin.flow.component.UI
import com.vaadin.flow.component.html.H1
import com.vaadin.flow.component.login.AbstractLogin.*
import com.vaadin.flow.component.login.LoginForm
import com.vaadin.flow.component.orderedlayout.FlexComponent.*
import com.vaadin.flow.component.orderedlayout.VerticalLayout
import com.vaadin.flow.router.BeforeEnterEvent
import com.vaadin.flow.router.BeforeEnterObserver
import com.vaadin.flow.router.PageTitle
import com.vaadin.flow.router.Route


@Route("login")
@PageTitle("Login")
class LoginView(
    val userService: UserService
) : VerticalLayout(), BeforeEnterObserver, ComponentEventListener<LoginEvent> {
    private val login = LoginForm()

    init {
        addClassName("login-view")
        setSizeFull()
        justifyContentMode = JustifyContentMode.CENTER
        alignItems = Alignment.CENTER
        login.addLoginListener(this)
        add(H1("Добро пожаловать!"), login)
    }

    override fun beforeEnter(beforeEnterEvent: BeforeEnterEvent) {
        if (beforeEnterEvent.location
                .queryParameters
                .parameters
                .containsKey("error")
        ) {
            login.isError = true
        }
    }

    override fun onComponentEvent(loginEvent: LoginEvent) {
        val authenticated = userService.findByUsername(loginEvent.username).password == loginEvent.password
        Utils.isAuthorized = authenticated
        if (authenticated) {
            UI.getCurrent().page.setLocation(LOGIN_SUCCESS_URL)
        } else {
            login.isError = true
        }
    }

    companion object {
        private const val LOGIN_SUCCESS_URL = "/"
    }
}