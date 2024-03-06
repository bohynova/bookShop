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

    override fun findIdsByName(name: String): List<Long> =
        jdbcTemplate.query("select * from author a where a.name like '%' || '$name' || '%'") { rs, _ ->
            rs.getLong("Id")
        }

    override fun create(author: Author) {
        jdbcTemplate.execute("insert into author(name) values ('${author.name}')")
    }
}