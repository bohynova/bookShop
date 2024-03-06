package by.starychonak.shop.dao.impl

import by.starychonak.shop.dao.UserDao
import by.starychonak.shop.entity.User
import org.springframework.jdbc.core.JdbcTemplate
import org.springframework.stereotype.Repository

@Repository
class UserDaoImpl (
    private val jdbcTemplate: JdbcTemplate
): UserDao {

    override fun findByUserName(username: String): User? {
        return jdbcTemplate.queryForObject(
            "select * from users where username = '$username'"
        ) { rs, _ -> User(rs.getString("username"), rs.getString("password")) }
    }

    override fun create(user: User) {
        jdbcTemplate.execute("insert into users values ('${user.username}', '${user.password}')")
    }

}