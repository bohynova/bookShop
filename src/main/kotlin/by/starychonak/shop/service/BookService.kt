package by.starychonak.shop.service

import by.starychonak.shop.entity.Book
import by.starychonak.shop.entity.BookDto

interface BookService {
    fun findAll(title: String? = null): List<BookDto>

    fun createBook(book: Book)
    fun createBook(books: List<Book>)
    fun fileDownload(title: String? = null)
}