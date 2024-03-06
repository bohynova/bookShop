package by.starychonak.shop.controller

import by.starychonak.shop.entity.Genre
import by.starychonak.shop.service.GenreService
import org.springframework.http.MediaType
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping(value = ["/api/genre"], produces = [MediaType.APPLICATION_JSON_VALUE])
class GenreController(
    val genreService: GenreService
) {

    @PostMapping
    fun create(@RequestBody genre: Genre) = genreService.create(genre)
}