package by.starychonak.shop.controller

import by.starychonak.shop.service.AuthorService
import by.starychonak.shop.service.impl.AuthorServiceImpl
import io.swagger.v3.oas.annotations.tags.Tag
import org.springframework.http.MediaType
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@Tag(name = "Author Controller", description = "Контроллер для взаимодействий по авторам")
@RequestMapping(value = ["/api/author"], produces = [MediaType.APPLICATION_JSON_VALUE])
class AuthorController (
    val authorService: AuthorService
) {

    @GetMapping
    fun create() = authorService.findAll()
}