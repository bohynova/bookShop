package by.starychonak.shop.controller

import by.starychonak.shop.entity.Author
import by.starychonak.shop.service.AuthorService
import org.springframework.http.MediaType
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping(value = ["/api/author"], produces = [MediaType.APPLICATION_JSON_VALUE])
class AuthorController (
    val authorService: AuthorService
) {

    @GetMapping
    fun findAll() = authorService.findAll()

    @PostMapping()
    fun createAuthor(
        @RequestBody author: Author
    ) = authorService.create(author)
}