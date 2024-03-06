package by.starychonak.shop.controller

import by.starychonak.shop.entity.Book
import by.starychonak.shop.service.BookService
import org.springframework.http.MediaType
import org.springframework.stereotype.Component
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping(value = ["/api/book"], produces = [MediaType.APPLICATION_JSON_VALUE])
class BookController(
    val bookService: BookService
) {

    @GetMapping
    fun findAll(
        @RequestParam(required = false) title: String?
    ) = bookService.findAll(title)

    @PostMapping
    fun createBook(
       @RequestBody book: Book
    ) = bookService.createBook(book)

    @PostMapping("/create-many")
    fun createBook(
        @RequestBody books: List<Book>
    ) = bookService.createBook(books)
}