package by.starychonak.shop.dao

import by.starychonak.shop.entity.Book
import by.starychonak.shop.entity.BookDto

interface BookDao {
    fun findAll(title: String?): List<BookDto>
    fun createBook(book: Book)
    fun createBook(books: List<Book>)
}