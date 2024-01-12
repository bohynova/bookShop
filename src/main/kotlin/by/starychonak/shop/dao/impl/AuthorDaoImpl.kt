package by.starychonak.shop.dao.impl

import by.starychonak.shop.dao.AuthorDao
import by.starychonak.shop.entity.Author
import org.springframework.jdbc.core.JdbcTemplate
import org.springframework.stereotype.Repository

@Repository
class AuthorDaoImpl(
    val jdbcTemplate: JdbcTemplate
) : AuthorDao {

    override fun findAll(): List<Author> {
        return jdbcTemplate.query("select * from author") { rs, _ ->
            Author(rs.getLong("Id"), rs.getString("name"))
        }
    }
}