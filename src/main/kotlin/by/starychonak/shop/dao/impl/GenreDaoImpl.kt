package by.starychonak.shop.dao.impl

import by.starychonak.shop.dao.GenreDao
import by.starychonak.shop.entity.Genre
import org.springframework.jdbc.core.JdbcTemplate
import org.springframework.stereotype.Repository

@Repository
class GenreDaoImpl(
    val jdbcTemplate: JdbcTemplate
) : GenreDao {

    override fun findAll(): List<Genre> {
        return jdbcTemplate.query("select * from genre") { rs, _ ->
            Genre(rs.getLong("Id"), rs.getString("name"))
        }
    }

    override fun findById(id: Long): Genre? {
        return jdbcTemplate.queryForObject(
            "select * from genre g where g.id = $id"
        ) { rs, _ -> Genre(rs.getLong("Id"), rs.getString("name")) }
    }

    override fun findByName(name: String): List<Genre> {
        return jdbcTemplate.query("select * from genre g where g.name like '%' || $name || '%'") { rs, _ ->
            Genre(
                rs.getLong("Id"), rs.getString("name")
            )
        }
    }

    override fun findIdsByName(name: String): List<Long> =
        jdbcTemplate.query("select * from genre g where g.name like '%$name%'") { rs, _ ->
            rs.getLong("Id")
        }

    override fun create(genre: Genre) {
        jdbcTemplate.execute("insert into genre(name) values ('${genre.name}')")
    }
}
