package by.starychonak.shop.dao

import by.starychonak.shop.entity.Author

interface AuthorDao {
    fun findAll(): List<Author>
}