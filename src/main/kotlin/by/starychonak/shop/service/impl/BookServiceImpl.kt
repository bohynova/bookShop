package by.starychonak.shop.service.impl

import by.starychonak.shop.dao.BookDao
import by.starychonak.shop.entity.Book
import by.starychonak.shop.entity.BookDto
import by.starychonak.shop.service.AuthorService
import by.starychonak.shop.service.BookService
import by.starychonak.shop.service.GenreService
import org.springframework.stereotype.Service
import java.io.File

@Service
class BookServiceImpl(
    val genreService: GenreService,
    val authorService: AuthorService,
    val bookDao: BookDao
) : BookService {
    override fun findAll(title: String?): List<BookDto> {

        return bookDao.findAll(title)
    }

    override fun createBook(book: Book) {
        bookDao.createBook(book)
    }

    override fun createBook(books: List<Book>) {
        bookDao.createBook(books)
    }

    override fun fileDownload(title: String?) {
        val list = findAll(title)
        val headers = "id,title,genre,author,price,sale,isBestseller,isNew,imagePath\n"
        val lines =
            list.map { "${it.id},${it.title},${it.genre},${it.author},${it.price},${it.sale},${it.isBestseller},${it.isNew},${it.imagePath}" }

        val filePath = "src/main/resources/export.csv"
        val result = headers + lines.joinToString("\n")

        File(filePath).writeText(result)
    }

}