package by.starychonak.shop.dao.impl

import by.starychonak.shop.dao.BookDao
import by.starychonak.shop.entity.Book
import by.starychonak.shop.entity.BookDto
import org.springframework.jdbc.core.JdbcTemplate
import org.springframework.stereotype.Repository

@Repository
class BookDaoImpl(
    val jdbcTemplate: JdbcTemplate
) : BookDao {

    override fun findAll(title: String?): List<BookDto> {
        val sb = StringBuilder(
            """select b.id,
                   b.title,
                   g.name as genre,
                   a.name as author,
                   b.price,
                   b.sale,
                   b.isbestseller,
                   get_available_quantity(b.id) available_quantity,
                   isnew,
                   image_path
               from book b
               join author a on a.id = b.author_id
               join genre g on g.id = b.genre_id""".trimIndent()
        )

        title?.let {
            sb.append("\nwhere lower(b.title) like lower('%$it%')")
        }
        return jdbcTemplate.query(sb.toString())
        { rs, _ ->
            BookDto(
                id = rs.getLong("id"),
                title = rs.getString("title"),
                genre = rs.getString("genre"),
                author = rs.getString("author"),
                price = rs.getDouble("price"),
                sale = rs.getInt("sale"),
                isBestseller = rs.getBoolean("isBestseller"),
                isNew = rs.getBoolean("isNew"),
                imagePath = rs.getString("image_path"),
                availableQuantity = rs.getLong("available_quantity")
            )
        }
    }


    override fun createBook(book: Book) {
        val bookPath = book.imagePath?.let { "'$it'" }
        jdbcTemplate.execute(
            "insert into book(title, genre_id, author_id, price, sale, isbestseller, isnew, image_path)" +
                    " values('${book.title}', ${book.genreId}, ${book.authorId}, ${book.price}, ${book.sale}, " +
                    "${book.isBestseller}, ${book.isNew}, $bookPath)"
        )
    }

    override fun createBook(books: List<Book>) {
        val values = books.map { book ->
            val bookPath = book.imagePath?.let { "'$it'" }
            "('${book.title}', ${book.genreId}, ${book.authorId}, ${book.price}, ${book.sale}, " +
                    "${book.isBestseller}, ${book.isNew}, $bookPath)"
        }
            .joinToString(separator = ",\n")

        jdbcTemplate.execute(
            "insert into book(title, genre_id, author_id, price, sale, isbestseller, isnew, image_path)" +
                    " values $values"
        )
    }
}