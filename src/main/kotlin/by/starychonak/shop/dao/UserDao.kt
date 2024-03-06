package by.starychonak.shop.dao

import by.starychonak.shop.entity.User

interface UserDao {
    fun findByUserName(username: String): User?
    fun create(user: User)
}